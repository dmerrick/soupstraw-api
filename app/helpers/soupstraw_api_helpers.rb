module SoupstrawAPIHelpers

  #TODO: figure out a good way to set this
  def is_deafguy?
    settings.app[:is_deafguy]
  end

  def is_media_center?
    settings.app[:is_media_center]
  end

  def is_authorized?
    return true if settings.disable_http_auth
    creds = [settings.app[:home_username], settings.app[:home_password]]
    auth ||= Rack::Auth::Basic::Request.new(request.env)
    auth.provided? && auth.basic? && auth.credentials && auth.credentials == creds
  end

  def media_center_api(path)
    uri = URI.parse('http://' + settings.app[:media_center_url] + path)
    request = Net::HTTP::Get.new(uri.request_uri)
    # uses the same PW as the home API
    request.basic_auth(settings.app[:home_username], settings.app[:home_password])
    #TODO: catch exceptions here
    http = Net::HTTP.new(uri.host, uri.port)
    http.request(request)
  end

  def tell_iTunes_to(command)
    "osascript -e 'tell application \"iTunes\" to #{command}'"
  end

end
