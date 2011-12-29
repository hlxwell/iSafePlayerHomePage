Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "42876356856", "9af076a32b62288d9614b084bfaf48f0", :scope => 'email,offline_access,read_stream', :display => 'popup'
end