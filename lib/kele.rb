require 'httparty'
require 'json'

class Kele
  include HTTParty
  include JSON

  attr_accessor :api_url, :auth_token

  def initialize(email, password)
    @api_url = 'https://www.bloc.io/api/v1'
    @auth_token = HTTParty.post('https://www.bloc.io/api/v1/sessions', body: {email: email, password: password}).parsed_response["auth_token"]

    if @auth_token==nil || @auth_token==false
      raise ArgumentError.new("That user has invalid credentials")
    end
  end

  def get_me
    response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = HTTParty.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_roadmap(roadmap_id)
    response = HTTParty.get("https://www.bloc.io/api/v1/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = HTTParty.get("https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

end
