class Kele
  attr_accessor :email, :password, :api_url, :auth_token

  def initialize(email, password)
    @email, @password = email, password
    @api_url = 'https://www.bloc.io/api/v1'
    @auth_token = 4
  end

end
