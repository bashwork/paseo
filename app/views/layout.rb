module Views
  class Layout < Mustache

    def bundled?
      File.exist?("#{RACK_ROOT}/public/css/bundle.css") &&
        File.exist?("#{RACK_ROOT}/public/js/bundle.js")
    end
  end
end
