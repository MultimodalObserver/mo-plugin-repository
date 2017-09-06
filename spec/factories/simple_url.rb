FactoryGirl.define do

  factory :simple_urls, class: Array do
    initialize_with {
      [
        ["htTtps://www.goOgle.com", "htttps", "google"],
        ["www.google.com.asdsa.erer.", "http", "com"],
        ["https://google.com", "https", "google"],
        ["google.com", "http", "google"],
        ["https://www.google.com/sdasd/3434/dfdf", "https", "google"],
        ["HTTps://www.google.com/asds#3434fsd", "https", "google"],
        ["www.google.com?aa=434&vb=343", "http", "google"],
        ["https://google.com?wwds", "https", "google"],

        ["https://....goo...gl.e.co......m.....?wwds", "https", "e"],
        ["https://..go..ogle.com?wwds", "https", "ogle"],
        ["https://go.ogle.....co...m.....?wwds", "https", "ogle"],
        ["ftp://..a..b..c..d..?wwds", "ftp", "b"]
      ]
     }
  end

end
