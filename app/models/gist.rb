class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :user

  def hash
    url.split('/').last
  end

  def self.create_gist(test_passage)
    result = GistQuestionService.new(test_passage.current_question,
                                     octokit_client).call

    user_gist_params = gist_params(test_passage, result)
    user_gist = test_passage.current_question.gists.new(user_gist_params)

    user_gist if gist_success?(result) && user_gist.save!
  end

  def self.octokit_client
    Octokit::Client.new(access_token: Rails.application.credentials.github_token)
  end

  def self.gist_params(test_passage, gist_response)
    { user: test_passage.user, url: gist_response['html_url'] }
  end

  def self.gist_success?(gist_response)
    !gist_response.nil? && !gist_response['html_url'].empty?
  end

  private_class_method :octokit_client, :gist_params, :gist_success?
end
