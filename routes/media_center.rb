class SoupstrawAPI < Sinatra::Base
  get '/?' do
    pass unless is_media_center?
    'hello, media center'
  end

  # not authorized cause it's on the home network
  get '/itunes/play' do
    pass unless is_media_center?
    "play iTunes here"
  end 
end
