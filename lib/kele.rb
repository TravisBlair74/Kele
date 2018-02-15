require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include JSON
  include Roadmap

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

  def get_messages(page = nil)
    if page != nil
      response = HTTParty.get("https://www.bloc.io/api/v1/message_threads", headers: { "authorization" => @auth_token }, body: { "page": page })
    else
      response = HTTParty.get("https://www.bloc.io/api/v1/message_threads", headers: { "authorization" => @auth_token })
    end

    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token, subject, stripped_text)
    HTTParty.post('https://www.bloc.io/api/v1/messages', headers: { "authorization" => @auth_token }, body: { "sender": sender, "recipient_id": recipient_id, "token": token, "subject": subject, "stripped-text": stripped_text })
  end

end
