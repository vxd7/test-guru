class GistQuestionService
  class Result
    attr_reader :gist_response

    def initialize(gist_response)
      @gist_response = gist_response
    end

    def success?
      !@gist_response.nil? && !@gist_response['html_url'].empty?
    end

    def html_url
      @gist_response['html_url']
    end
  end

  def initialize(question, client = default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    Result.new(@client.create_gist(gist_params))
  end

  private

  def gist_params
    {
      description: I18n.t('.gist_question_service.description',
                          test_title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.content]
    content += @question.answers.pluck(:content)
    content.join("\n")
  end

  def default_client
    GitHubClient.new
  end
end
