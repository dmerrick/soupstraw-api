class SoupstrawAPI < Sinatra::Base
  get '/?' do
    pass unless is_deafguy?
    'hello, deafguy'
  end

  get '/bladehealth', auth: :authorized do
    pass unless is_deafguy?
    content_type :json
    # -j is for json output
    #TODO: add -v for configuration data
    `/usr/local/bin/bladehealth -j`
  end

  #TODO: more clever way to define these routes
  get '/itunes/volume/:command', auth: :authorized do
    pass unless is_deafguy?
    content_type :json
    response = media_center_api("/itunes/volume/#{params[:command]}")
    response.body
  end

  get '/itunes/:command', auth: :authorized do
    pass unless is_deafguy?
    content_type :json
    response = media_center_api("/itunes/#{params[:command]}")
    response.body
  end

end
