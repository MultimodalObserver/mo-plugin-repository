require 'uri'

class SimpleUrl

  attr_accessor :scheme, :full_url, :guess_host, :full_url_default_scheme

  def initialize(string_url)
    @full_url = string_url.strip
    @full_url_default_scheme = @full_url
    arr = parse(string_url)
    @scheme = arr[0].downcase
    body = arr[3]
    @guess_host = get_host(body).downcase
  end

  private
  def get_host(body)
    return "" if body.nil?

    parts = body.split(".").select do |str|
      !str.empty?
    end

    if parts.empty?
      return ""
    end
    if parts.count == 1 || parts.count == 2
      return parts[0]
    end
    if parts.count % 2 == 0
      return parts[(parts.count - 1) / 2]
    end
    return parts[parts.count / 2]

  end

  def parse(url)
    array = url.scan(URI.regexp)
    if array.empty?
      @full_url_default_scheme = "http://" + url
      array = @full_url_default_scheme.scan(URI.regexp)
    end
    return array[0]
  end
end
