RACK_ENV  = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT = File.expand_path(File.dirname(__FILE__) + '/..')

# std-lib
require 'open-uri'

# bundled gems
require 'sinatra/base'
require 'nokogiri'
require 'yajl'
require 'mustache/sinatra'
require 'curb'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

# paseo

require 'helpers'
require 'models/db'
require 'views/layout'
