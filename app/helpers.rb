require 'helpers/pretty_printing'
require 'helpers/sinatra'
require 'yaml'

module Paseo
  module Helpers
    include Paseo::Helpers::PrettyPrinting
    include Paseo::Helpers::Sinatra

    #
    # helpers defined here are available to all views and sinatra routes
    #

    # debug { puts "hi!" }
    def debug
      yield if @debug
    end

    # sha(hash) => '01578ad840f1a7eba2bd202351119e635fde8e2a'
    def sha(thing)
      Digest::SHA1.hexdigest(thing.to_s)
    end

    def logged_in?
      !!@user
    end

    def user
      @user
    end

    # for sorting hashes with symbol keys
    def sort_hash(hash)
      hash.to_a.sort_by { |a, b| a.to_s }
    end

    def next_seo
      return unless logged_in?

      if @hurl
        hurls = @user.hurls
        hurls.each_with_index do |hurl, i|
          if hurl['id'] == @hurl['id']
            return i-1 >= 0 ? hurls[i-1]['id'] : nil
          end
        end
        nil
      end
    end

    def prev_seo
      return unless logged_in?

      if @hurl.empty? && @user.hurls.any?
        @user.latest_hurl_id
      elsif @hurl.any?
        hurls = @user.hurls
        hurls.each_with_index do |hurl, i|
          if hurl['id'] == @hurl['id']
            return hurls[i+1] ? hurls[i+1]['id'] : nil
          end
        end
        nil
      end
    end

  end
end
