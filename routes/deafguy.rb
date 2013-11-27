class SoupstrawAPI < Sinatra::Base
  get '/?' do
    'hello, deafguy'
  end

  get '/bladehealth', auth: :authorized do
    #FIXME: this needs JSON or something
    `/usr/local/bin/bladehealth`
  end
end
