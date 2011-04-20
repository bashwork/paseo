require 'rubygems'
require 'nokogiri'
require 'open-uri'

#------------------------------------------------------------
# initialization
#------------------------------------------------------------
url  = 'index.html'
page = Nokogiri::HTML(open(url))
metas = { 'url' => url }
links = {}

#------------------------------------------------------------
# ranks
#------------------------------------------------------------
# http://www.trustrank.org/
# pagerank
# seomoz - http://apiwiki.seomoz.org/w/page/13991148/SEOmoz-Free-API
# alexarank - http://aws.amazon.com/awis/
# uri, keywords
# http://api.nahklick.de/seo/index.php?method=Google_Page_Rank&url=http://www.google.com
#------------------------------------------------------------

#------------------------------------------------------------
# extract robots
#------------------------------------------------------------

def extract_robots(uri)
  robots = DB.get(:robots, uri) || {}
  parsed = URI.parse(url)
  page   = open(parsed.scheme + parsed.host + '/robots.txt')
  page.readlines.each do |line|
    key,value = line.strip.split ':'
    robots[key] = [] if robots[key].nil?
    robots[key] << value.strip
  end
  robots
end

#------------------------------------------------------------
# extract page title
#------------------------------------------------------------
page.xpath('//head/title').each do |title|
  metas['title'] = title.content || ""
end

#------------------------------------------------------------
# extract page meta information
#------------------------------------------------------------
page.xpath('//head/meta').each do |field|
  key = field.keys.find { |f| f != 'content' }.first
  metas['meta-' + field[key]] = field['content'] || ""
end

#------------------------------------------------------------
# extract page outbound hyperlinks
#------------------------------------------------------------
page.xpath('//a').each do |link|
  if link['href'] and link['href'].include? 'http' and
     link['rel'] != 'nofollow':
     links[link['href']] = link['title'] || link.content.strip || ""
  end
end

#------------------------------------------------------------
# debugging prints
#------------------------------------------------------------
puts "\nmetas"
metas.each {|k,v| puts k + " => " + v }
puts "\nlinks"
links.each {|k,v| puts k + " => " + v }
