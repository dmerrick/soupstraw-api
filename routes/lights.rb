class SoupstrawAPI < Sinatra::Base

  get '/lights/on', auth: :authorized do
    settings.hue.lights.each do |light|
      light.on!
    end
    #TODO: better response
    { status: 'on' }.to_json
  end

  get '/lights/off', auth: :authorized do
    settings.hue.lights.each do |light|
      light.off!
    end
    #TODO: better response
    { status: 'off' }.to_json
  end

end