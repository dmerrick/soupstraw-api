class SoupstrawAPI < Sinatra::Base
  get '/?' do
    content_type 'text/plain'
    'hello, world'
  end
end
