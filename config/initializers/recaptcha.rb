# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = '6LcEiUAUAAAAAPnNOCGhm6rphB098cCZi9zCTiom'
  config.secret_key = '6LcEiUAUAAAAAKNamOD1QktI_pQ0UQuFw50mQiGD'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end
