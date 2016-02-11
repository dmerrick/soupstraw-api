class SoupstrawAPI < Sinatra::Base
  get '/?' do
    pass unless is_deafguy?
    content_type 'text/plain'
    'hello, deafguy'
  end

  # this doesn't currently require auth, but it could
  get '/stacklight' do
    pass unless is_deafguy?
    content_type 'text/plain'
    # this is how it used to work: `/usr/local/bin/autostrobe.py`
    blue, red, amber, green	= [0, 0, 0, 0]
    # make sure it's never all off
    until blue + red + amber + green > 0
      blue, red, amber, green	= [ rand(2), rand(2), rand(2), rand(2) ]
    end
    url = "https://agent.electricimp.com/mNpmQNrLzFmS?blue_light=#{blue}&red_light=#{red}&amber_light=#{amber}&green_light=#{green}"
    open(url).read
  end

  get '/bladehealth', auth: :authorized do
    pass unless is_deafguy?
    content_type :json
    # -j is for json output
    #TODO: add -v for configuration data
    `/usr/local/bin/bladehealth -j`
  end

  # return OK if the media center is alive and
  # running the right configuration
  get '/healthcheck/mediacenter' do
    pass unless is_deafguy?
    content_type 'text/plain'
    begin
      response = media_center_api('/')
    rescue Errno::ECONNREFUSED
      return 'MEDIACENTERDOWN'
    end
    return 'NOTMEDIACENTER' unless response.body =~ /media center/
    'OK'
  end

  get '/wall_remote/:command', auth: :authorized do
    pass unless is_deafguy?
    content_type :json
    response = media_center_api("/itunes/#{params[:command]}")
    response.body
  end

end
