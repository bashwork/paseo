require 'rubygems'
require 'w3c_validators'

#--------------------------------------------------------------------#
# Markup validator
#--------------------------------------------------------------------#
def validate_xhtml(uri)
  @validator = W3CValidators::MarkupValidator.new
  @validator.validate_uri(uri)
end

#--------------------------------------------------------------------#
# CSS validator
#--------------------------------------------------------------------#
def validate_css(uri)
  @validator = W3CValidators::CSSValidator.new
  @validator.validate_uri(uri)
end

#if results.errors.length > 0
#  results.errors.each do |error|
#    puts error.to_s
#  end
#else
#  puts "valid"
#end
