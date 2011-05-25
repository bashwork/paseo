require 'app/libraries'

module Paseo
  class App < Sinatra::Base

    # ----------------------------------------------------------------
    # static
    # ----------------------------------------------------------------
    register Mustache::Sinatra

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
      @seo ? mustache(:index) : not_found
    end


    # ----------------------------------------------------------------
    # api routes
    # ----------------------------------------------------------------

    get '/api/seo/?' do
      json(@database.list)
    end

    get '/api/seo/:url/?' do
      seo = @database.find(params[:url])
      json(seo ? seo : {:error => 'url does not exist'})
    end

    post '/api/seo' do
      url = params.values_at(:url)
      return json(:error => 'maybe stop talking so fast?') if rate_limited?
      return json(:error => 'come on, that is not a real url') if invalid_url?(url)

      result = @database.find(url)
      return result if result

      result = fetch(url)
      @database.save(result)
      result
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
    # Check if the url is actually valid.
    #
    def invalid_url?(url)
      false
    end

    # turn post_data into a string for PUT requests
    def stringify_data(data)
      if data.is_a? String
        data
      elsif data.is_a? Array
        data.map { |x| stringify_data(x) }.join("&")
      elsif data.is_a? Curl::PostField
        data.to_s
      else
        raise "Cannot stringify #{data.inspect}"
      end
    end
  end
end
