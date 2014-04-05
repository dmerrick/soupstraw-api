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

  get '/play', auth: :authorized do
    pass unless is_deafguy?
    media_center_api('/itunes/play')
  end
end
