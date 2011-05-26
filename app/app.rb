require 'app/libraries'

module Paseo
  class App < Sinatra::Base

    # ----------------------------------------------------------------
    # settings
    # ----------------------------------------------------------------
    register Mustache::Sinatra
    helpers Paseo::Helpers

    dir = File.dirname(File.expand_path(__FILE__))

    set :public,   "#{dir}/public"
    set :root,     RACK_ROOT
    set :app_file, __FILE__
    set :static,   true

    set :views, "#{dir}/templates"

    set :mustache, {
      :namespace => Object,
      :views     => "#{dir}/views",
      :templates => "#{dir}/templates"
    }

    enable :sessions

    def initialize(*args)
      super
      @debug = ENV['DEBUG']
      @database = DB.new
    end


    # ----------------------------------------------------------------
    # static routes
    # ----------------------------------------------------------------

    get '/' do
      @seo = {}
      mustache :index
    end

    get '/about/?' do
      mustache :about
    end

    get '/seo/:url/?' do
      @seo = @database.find(params[:url])
      @seo ? mustache(:report) : not_found
    end


    # ----------------------------------------------------------------
    # api routes
    # ----------------------------------------------------------------

    get '/api/seo/?' do
      json(@database.list)
    end

    post '/api/seo/?' do
      url = params[:url]
      return json(:error => 'maybe stop talking so fast?') if rate_limited?
      return json(:error => 'come on, that is not a real url') if invalid_url?(url)

      result = @database.find(url)
      result = @database.save(fetch(url)) if not result
      json(result)
    end


    # ----------------------------------------------------------------
    # error handlers
    # ----------------------------------------------------------------

    not_found do
      mustache :"404"
    end

    error do
      mustache :"500"
    end

    # ----------------------------------------------------------------
    # helpers
    # ----------------------------------------------------------------

    #
    # Check if the current user is making too
    # many requests.
    #
    def rate_limited?
      false
    end

    #
    # Check if the |url| is actually valid.
    #
    def invalid_url?(url)
      (url =~ URI::regexp).nil?
    end

  end
end
