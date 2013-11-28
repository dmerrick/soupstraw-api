class SoupstrawAPI < Sinatra::Base
  get '/?' do
    'hello, deafguy'
  end

  get '/bladehealth', auth: :authorized do
    # -j is for json output
    #TODO: add -v for configuration data
    `/usr/local/bin/bladehealth -j`
  end
end
