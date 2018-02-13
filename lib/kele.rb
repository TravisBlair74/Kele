require 'httparty'

class Kele
  attr_accessor :api_url, :auth_token

  def initialize(email, password)
    @api_url = 'https://www.bloc.io/api/v1'
    @auth_token = HTTParty.get("https://blocapi.docs.apiary.io/#reference/0/sessions/retreive-auth-token", {email: email, password: password})
  end

end
