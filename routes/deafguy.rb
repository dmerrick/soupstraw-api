class SoupstrawAPI < Sinatra::Base
  get '/?' do
    pass unless is_deafguy?
    'hello, deafguy'
  end

  get '/bladehealth', auth: :authorized do
    pass unless is_deafguy?
    # -j is for json output
    #TODO: add -v for configuration data
    `/usr/local/bin/bladehealth -j`
  end

  get '/itunes/play', auth: :authorized do
    pass unless is_deafguy?
    response = media_center_api('/itunes/play')
    response.body
  end

  get '/itunes/pause', auth: :authorized do
    pass unless is_deafguy?
    response = media_center_api('/itunes/pause')
    response.body
  end
end
