require 'w3c_validators'

module Paseo
  module Helpers
  
  class Validator

    #
    # Perform markup validation for the specified
    # |url|.
    #
    def self.validate_xhtml(url)
      @validator = W3CValidators::MarkupValidator.new
      @validator.validate_uri(url)
    end

    #
    # Perform CSS validation for the specified
    # |url|.
    #
    def self.validate_css(url)
      @validator = W3CValidators::CSSValidator.new
      @validator.validate_uri(url)
    end

  end

  end
end
    #if results.errors.length > 0
    #  results.errors.each do |error|
    #    puts error.to_s
    #  end
    #else
    #  puts "valid"
    #end
