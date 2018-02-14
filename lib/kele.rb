require 'httparty'
require 'json'

class Kele
  include HTTParty
  include JSON

  attr_accessor :api_url, :auth_token

  def initialize(email, password)
    @api_url = 'https://www.bloc.io/api/v1'
    @auth_token = HTTParty.post('https://www.bloc.io/api/v1/sessions', body: {email: email, password: password}).parsed_response["auth_token"]

  end

  def get_me
    response = HTTParty.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

end
