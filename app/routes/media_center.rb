class SoupstrawAPI < Sinatra::Base
  get '/?' do
    pass unless is_media_center?
    'hello, media center'
  end

  # not authorized cause it's on the home network
  get '/itunes/play' do
    pass unless is_media_center?
    "TODO: play iTunes here"
  end 

  # not authorized cause it's on the home network
  get '/itunes/pause' do
    pass unless is_media_center?
    "TODO: pause iTunes here"
  end

end
