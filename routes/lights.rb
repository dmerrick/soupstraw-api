class SoupstrawAPI < Sinatra::Base

  get '/lights', auth: :authorized do
    content_type :json
    lights = {}
    #TODO: add a Light#to_json method to philips_hue gem
    #TODO: also add light.name as symbol
    settings.hue.lights.inject(lights) do |hash, light|
      name = light.name.split.map(&:capitalize).join(' ')
      hash[name] = light.state.merge(id: light.light_id)
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
