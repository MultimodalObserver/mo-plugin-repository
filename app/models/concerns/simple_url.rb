require 'uri'

class SimpleUrl

  # http, https, ftp, etc
  attr_accessor :scheme

  # given URL (passed to the constructor)
  attr_accessor :full_url

  # http://www.google.com ---> "google"
  attr_accessor :guess_host

  # URL with a default scheme (if the URL originally didn't have a
  # scheme, and the default was set to be FTP, then this URL starts with ftp://)
  attr_accessor :full_url_default_scheme

  # If the URL was http://youtube.com/aaa/bbb/ccc
  # then this array contains ["aaa", "bbb", "ccc"]
  attr_accessor :path_array

  def initialize(string_url, default_scheme = 'http')
    default_scheme.downcase! if !default_scheme.nil?
    @full_url = string_url.strip
    @full_url_default_scheme = set_default_scheme @full_url, default_scheme
    arr = parse @full_url_default_scheme
    @scheme = arr[0].downcase
    body = arr[3]
    @path_array = get_path_array arr[6]
    @guess_host = get_host(body).downcase
  end

  private

  #
  # Gets the URL path, for instance
  # http://youtube.com/aaa/bbb/ccc
  # returns
  # ["aaa", "bbb", "ccc"]
  #
  def get_path_array(path_parts)
    return [] if path_parts.nil?
    path_parts.split('/').reject { |x| x.empty? }
  end


  #
  # Gets the URL host using some heuristics
  #
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


  #
  # Adds a default scheme if the URL didn't have one
  #
  def set_default_scheme(url, default_scheme)
    array = url.scan(URI.regexp)
    if array.empty?
      url = default_scheme + "://" + url
    end
    return url
  end


  #
  # Breaks the URL and returns each part
  #
  def parse(url)
    array = url.scan(URI.regexp)
    return array[0]
  end
end
