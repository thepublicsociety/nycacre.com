Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "245366926738.apps.googleusercontent.com", "y4s_tMm7o_PvPQIJWXbdCjtE", {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
    redirect_uri:'http://development.metatroid.com/auth/google_oauth2/callback'
  }
  provider :facebook, "327126097413821", "148857c67c37246e78621858231a1620", {
    :scope => 'read_stream, manage_pages, user_groups', :display => 'page'
  }
end