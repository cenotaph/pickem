
OmniAuth.config.on_failure = Proc.new do |env|
  UsersController.action(:omniauth_failure).call(env)
  #this will invoke the omniauth_failure action in UsersController.
end
APPROVED_USERS = ENV['approved_users'].split(/\,\s*/).map(&:strip).to_a
APPROVED_ADMINS = ENV['approved_admins'].split(/\,\s*/).map(&:strip).to_a