require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include JSON
  include Roadmap
  base_uri "https://www.bloc.io/api/v1"

  attr_reader :auth_token

  def initialize(email, password)
    @auth_token = self.class.post("/sessions",
      body: {email: email, password: password})["auth_token"]

    if auth_token.nil?
      raise ArgumentError.new("That user has invalid credentials")
    end
  end

  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability",
      headers: { "authorization" => auth_token })
    JSON.parse(response.body)
  end

  def get_messages(page=nil)
    if page
      response = self.class.get("/message_threads",
        headers: { "authorization" => auth_token }, body: { "page": page })
    else
      response = self.class.get("/message_threads",
        headers: { "authorization" => auth_token })
    end

    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, subject, stripped_text)
    self.class.post("/messages",
      headers: { "authorization" => auth_token },
      body: { "sender": sender, "recipient_id": recipient_id, "subject": subject, "stripped-text": stripped_text })
  end

  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    self.class.post("/checkpoint_submissions",
      headers: { "authorization" => auth_token },
      body: { "assignment_branch": assignment_branch, "assignment_commit_link": assignment_commit_link, "checkpoint_id": checkpoint_id, "comment": comment, "enrollment_id": enrollment_id })
  end

end
