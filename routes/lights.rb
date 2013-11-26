class SoupstrawAPI < Sinatra::Base

  get '/lights/on' do
    settings.hue.lights.each do |light|
      light.on!
    end
    #TODO: better response
    'on'
  end

  get '/lights/off' do
    settings.hue.lights.each do |light|
      light.off!
    end
    #TODO: better response
    'off'
  end

end
