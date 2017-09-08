require 'uri'

class SimpleUrl

  attr_accessor :scheme, :full_url, :guess_host, :full_url_default_scheme, :path_array

  def initialize(string_url, default_scheme = 'http')
    default_scheme.downcase! if !default_scheme.nil?
    @full_url = string_url.strip
    @full_url_default_scheme = @full_url
    arr = parse(string_url, default_scheme)
    @scheme = arr[0].downcase
    body = arr[3]
    @path_array = get_path_array arr[6]
    @guess_host = get_host(body).downcase
  end

  private

  def get_path_array(path_parts)
    return [] if path_parts.nil?
    path_parts.split('/').reject { |x| x.empty? }
  end


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

  def parse(url, default_scheme)
    array = url.scan(URI.regexp)
    if array.empty?
      @full_url_default_scheme = default_scheme + "://" + url
      array = @full_url_default_scheme.scan(URI.regexp)
    end
    return array[0]
  end
end
