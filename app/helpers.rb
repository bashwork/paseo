require 'helpers/sinatra'
require 'helpers/seoparser'
require 'helpers/validator'

module Paseo
  module Helpers
  include Paseo::Helpers::Sinatra

  #
  # Given a |url|, retrieve all the seo data
  # that is associated with that page.
  #
  def fetch(url)
    response = Curl::Easy.http_get(url)
    results  = parse_seo(response.body_str)
    results.update({
      :url     => url,
      :robots  => extract_robots(url),
      :headers => response.headers,
      :cookies => response.cookies,
      :size    => response.downloaded_bytes,
      :speed   => response.download_speed })
  end

  #
  # Given a pages |body|, extract all the seo
  # data that we find relevant.
  #
  def parse_seo(body)
    parser = SeoParser.new(body)
    return {
      :meta  => parser.extract_meta,
      :words => parser.extract_frequent_words,
      :title => parser.extract_title,
      :links => parser.extract_links }
  end

  #
  # Given a |uri|, return the data in the
  # root robots.txt file.
  #
  def extract_robots(url)
    robots = {}
    file = get_url_root(url) + '/robots.txt'
    page = Curl::Easy.http_get(file)
    return robots if page.response_code != 200

    page.body_str.each do |line|
      key,value = line.strip.split ':'
      robots[key] = [] if robots[key].nil?
      robots[key] << value.strip
    end
    robots
  end

  #
  # Given a |url|, peroform a number of validation
  # tests on its markup.
  #
  def validate(url)
    return {
      :xhtml => Validator.validate_xhtml(url),
      :css   => Validator.validate_css(url)
    }
  end

  #
  # Given a |url|, return just the root
  # of the host.
  #
  def get_url_root(url)
    url.split('/')[0..2].join('/')
  end

  end
end
