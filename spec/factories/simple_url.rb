FactoryGirl.define do

  factory :simple_urls, class: Array do
    initialize_with {
      [
        ["htTtps://www.goOgle.com", "htttps", "google"],
        ["www.google.com.asdsa.erer.   ", "http", "com"],
        ["https://google.com", "https", "google"],
        ["google.com", "http", "google"],
        ["https://www.google.com/sdasd/3434/dfdf", "https", "google"],
        ["HTTps://www.google.com/asds#3434fsd", "https", "google"],
        ["www.google.com?aa=434&vb=343", "http", "google"],
        ["https://google.com?wwds", "https", "google"],
        ["https://....goo...gl.e.co......m.....?wwds", "https", "e"],
        ["https://..go..ogle.com?wwds", "https", "ogle"],
        ["https://go.ogle.....co...m.....?wwds", "https", "ogle"],
        ["ftp://..a..b..c..d..?wwds", "ftp", "b"],
        ["http://", "http", ""],
        ["  htTps://", "https", ""],
        ["ftp://", "ftp", ""],
        ["", "http", ""]
      ]
     }
  end


  factory :simple_urls_add_http, class: Array do
    initialize_with {
      [
        ["   htTtps://www.goOgle.com", "htTtps://www.goOgle.com"],
        ["www.google.com.asdsa.erer.    ", "http://www.google.com.asdsa.erer."],
        ["     https://google.com", "https://google.com"],
        ["  google.com   ", "http://google.com"],
        ["", "http://"]
      ]
     }
  end

  factory :simple_urls_add_custom_scheme, class: Array do
    initialize_with {
      [
        ["htTtps://www.goOgle.com    ", nil, "htTtps://www.goOgle.com"],
        ["www.google.com.asdsa.erer.", "FtP   ", "ftp://www.google.com.asdsa.erer."],
        ["https://google.com", nil, "https://google.com"],
        [" google.com  ", "https ", "https://google.com"],
        ["", "   AlOhA ", "aloha://"]
      ]
     }
  end


  factory :simple_urls_path_array, class: Array do
    initialize_with {
      [
        ["htTtps://www.goOgle.com", [] ],
        ["  www.google.com.asdsa.erer/a/b//c///?asd34#.", ["a", "b", "c"] ],
        ["     www.google.com.asdsa.erer////a//b//c///?asd34#.", ["a", "b", "c"] ],
        ["www.google.com.asdsa.erer/a/bc/////de///?asd34#.      ", ["a", "bc", "de"] ],
        ["  www.google.com.asdsa.erer/a///////?asd34#.", ["a"] ],
        ["www.google.com.asdsa.erer///////a#aa?asd34#.   ", ["a"] ],
        ["https://google.com/", [] ],
        ["    google.com/aaaa ", ["aaaa"] ],
        ["    ", [] ]
      ]
     }
  end




end
