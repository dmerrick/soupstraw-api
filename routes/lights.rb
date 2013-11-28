class SoupstrawAPI < Sinatra::Base

  get '/lights', auth: :authorized do
    content_type :json
    lights = {}
    settings.hue.lights.inject(lights) do |hash, light|
      hash[light.light_id] = { name: light.name }
      hash
    end
    lights.to_json
  end

  get '/lights/on', auth: :authorized do
    content_type :json
    settings.hue.lights.each do |light|
      light.on!
    end
    #TODO: better response
    { status: 'on' }.to_json
  end

  get '/lights/off', auth: :authorized do
    content_type :json
    settings.hue.lights.each do |light|
      light.off!
    end
    #TODO: better response
    { status: 'off' }.to_json
  end

end
