Doorkeeper.configure do
  orm :active_record
  resource_owner_authenticator do
    session[:return_route] = request.fullpath
    User.find_by(id: session[:user_id]) || redirect_to(root_url)
  end
  authorization_code_expires_in 10.minutes
  access_token_expires_in 2.hours
  access_token_generator 'Doorkeeper::JWT'
  use_refresh_token
  enable_application_owner confirmation: true
end

Doorkeeper::JWT.configure do
  token_payload do |opts|
    user = User.find(opts[:resource_owner_id])

    {
      gen_id: Base64.encode64(rand(1000).to_s),
      user: {
        id: user.id,
        email: user.email
      }
    }
  end
  secret_key Rails.application.secrets[:secret_key_base]
  encryption_method :hs512
end
