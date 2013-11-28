class SoupstrawAPI < Sinatra::Base
  get '/?' do
    'hello, deafguy'
  end

  get '/bladehealth', auth: :authorized do
    # -j is for json output
    `/usr/local/bin/bladehealth -j`
  end
end
