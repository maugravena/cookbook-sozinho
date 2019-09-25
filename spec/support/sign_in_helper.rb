module SignInHelper
  def sign_in_basic
    @env ||= {}
    email = 'user@email.com'
    password = '123456'
    
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end
