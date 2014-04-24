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

  #TODO: add brightness controls

  get '/lights/living_room/on', auth: :authorized do
    content_type :json
    settings.app[:living_room_lights].each do |light_id|
      light = settings.hue.light(light_id)
      light.on!
    end
    #TODO: better response
    { status: 'on' }.to_json
  end

  get '/lights/living_room/off', auth: :authorized do
    content_type :json
    settings.app[:living_room_lights].each do |light_id|
      light = settings.hue.light(light_id)
      light.off!
    end
    #TODO: better response
    { status: 'off' }.to_json
  end

  # reset living room light(s) to white
  get '/lights/living_room/reset', auth: :authorized do
    content_type :json
    settings.app[:living_room_lights].each do |light_id|
      light = settings.hue.light(light_id)
      light.on!
      light.brightness = 240
      light.xy = colors['white']
    end
    #TODO: better response
    { status: 'reset' }.to_json
  end

  # reset bedroom light(s) to white
  get '/lights/bedroom/reset', auth: :authorized do
    content_type :json
    settings.app[:bedroom_lights].each do |light_id|
      light = settings.hue.light(light_id)
      light.on!
      light.brightness = 240
      light.xy = colors['white']
    end
    #TODO: better response
    { status: 'reset' }.to_json
  end

  get '/lights/toggle/?', auth: :authorized do
    @light_id = request[:light_id] || 1
    redirect "/lights/toggle/#{@light_id}?#{request.query_string}"
  end

  get '/lights/toggle/:id', auth: :authorized do
    content_type :json

    light_id = params[:id]
    light = settings.hue.light(light_id)

    if light.on?
      light.off!
      status = 'off'
    else
      light.on!
      status = 'on'
    end

    { status: status, light_id: light_id }.to_json
  end

  get '/lights/flash/?', auth: :authorized do
    @light_id = request[:light_id] || 1
    redirect "/lights/flash/#{@light_id}?#{request.query_string}"
  end

  get '/lights/flash/:id', auth: :authorized do
    content_type :json

    light_id = params[:id]
    status = {}
    status[:light] = settings.hue.light(light_id)

    # set some defaults
    status[:repeat] = request[:repeat] ? request[:repeat].to_i : 1
    status[:delay]  = request[:delay] ? request[:delay].to_i : 1
    status[:crazy]  = request[:crazy] || false
    status[:color]  = colors[request[:color]] || colors['red']

    status[:repeat].times do |n|
      puts "flashing light ##{light_id}"
      status[:light].flash(status[:color], status[:delay], status[:crazy])
      sleep status[:delay] unless status[:repeat] == n+1
    end

    status.to_json
  end

end
