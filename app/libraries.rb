RACK_ENV  = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT = File.expand_path(File.dirname(__FILE__) + '/..')

# std lib
require 'open3'
require 'uri'

# bundled gems
require 'sinatra/base'
require 'nokogiri'
require 'yajl'
require 'mustache/sinatra'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

# paseo

require 'models/db'
require 'models/seo'
