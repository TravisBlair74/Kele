require 'httparty'

class Kele
  include HTTParty
  attr_accessor :api_url, :auth_token

  def initialize(email, password)

    @api_url = 'https://www.bloc.io/api/v1'
    @auth_token = HTTParty.post(@api_url, body: {email: email, password: password}).parsed_response["auth_token"]

    if @auth_token==nil || @auth_token==false
      puts "Invalid credentials"
    end
  end

end
