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

  # not authorized cause it's on the home network
  get '/itunes/stop' do
    pass unless is_media_center?
    content_type :json
    `#{tell_iTunes_to('stop')}`.to_json
  end

  # not authorized cause it's on the home network
  get '/itunes/next' do
    pass unless is_media_center?
    content_type :json
    `#{tell_iTunes_to('next track')}`.to_json
  end

  # not authorized cause it's on the home network
  get '/itunes/previous' do
    pass unless is_media_center?
    content_type :json
    `#{tell_iTunes_to('previous track')}`.to_json
  end

end
