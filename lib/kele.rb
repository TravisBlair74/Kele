require 'httparty'

class Kele
  attr_accessor :api_url, :auth_token

  def initialize(email, password)

    @api_url = 'https://www.bloc.io/api/v1'
    @auth_token = HTTParty.post("https://www.bloc.io/api/v1/sessions", body: {email: email, password: password})
  end

end
