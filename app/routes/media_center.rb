class SoupstrawAPI < Sinatra::Base
  get '/?' do
    pass unless is_media_center?
    'hello, media center'
  end

  # not authorized cause it's on the home network
  get '/itunes/play' do
    pass unless is_media_center?
    content_type :json
    `#{tell_iTunes_to('play')}`.to_json
  end 

  # not authorized cause it's on the home network
  get '/itunes/pause' do
    pass unless is_media_center?
    content_type :json
    `#{tell_iTunes_to('pause')}`.to_json
  end

end
