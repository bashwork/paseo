require 'curb'

module Paseo
  module Helpers

  def fetch(url)

    response = Curl::Easy.http_get(url)
    results  = parse_seo(reponse.body_str)
    results.update
      :url     => url,
      :headers => response.headers,
      :cookies => response.cookies,
      :size    => response.downloaded_bytes,
      :speed   => response.download_speed,
    
  end

end
