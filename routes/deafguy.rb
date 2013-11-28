class SoupstrawAPI < Sinatra::Base
  get '/?' do
    'hello, deafguy'
  end

  get '/bladehealth', auth: :authorized do
    #TODO: eventually remove the -p
    # -j is for json output
    # -p is for pretty-printing
    `/usr/local/bin/bladehealth -j -p`
  end
end
