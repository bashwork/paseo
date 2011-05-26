require 'nokogiri'

module Paseo
  module Helpers
  
  class SeoParser

    #
    # Initialize a new seo parser from the
    # supplied |body| text.
    #
    def initialize(body)
      @body = body
      @page = Nokogiri::HTML(body)
    end

    #
    # extract the page title
    #
    def extract_title
      result = ""
      @page.xpath('//head/title').each do |title|
        result = title.content
      end

      result
    end

    #
    # extract the page meta information
    #
    def extract_meta
      meta = {}
      @page.xpath('//head/meta').each do |field|
        key = field.keys.find { |f| f != 'content' }.first
        meta[field[key]] = field['content'] || ""
      end

      meta
    end

    #
    # extract page outbound hyperlinks
    #
    def extract_links
      links = {}
      @page.xpath('//a').each do |link|
        if link['href'] and link['href'].include? 'http' and
           link['rel'] != 'nofollow':
           links[link['href']] = link['title'] || link.content.strip || ""
        end
      end

      links
    end

    #
    # extract frequent words
    #
    def extract_frequent_words
      {}
    end
  end

  end
end

