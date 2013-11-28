module SoupstrawAPIHelpers

  #TODO: figure out a good way to set this
  def is_deafguy?
    true
  end

  def is_authorized?
    #TODO: figure out why this doesnt work
    #return true if settings.environment == 'development'
    creds = [settings.app[:home_username], settings.app[:home_password]]
    auth ||= Rack::Auth::Basic::Request.new(request.env)
    auth.provided? && auth.basic? && auth.credentials && auth.credentials == creds
  end

end
