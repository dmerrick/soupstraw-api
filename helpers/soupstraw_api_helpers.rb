module SoupstrawAPIHelpers

  #TODO: figure out a good way to set this
  def is_deafguy?
    true
  end

  def is_authorized?
    creds = [settings.app[:home_username], settings.app[:home_password]]
    auth ||= Rack::Auth::Basic::Request.new(request.env)
    auth.provided? && auth.basic? && auth.credentials && auth.credentials == creds
  end

end
