class GitHubClient
  ROOT_ENDPOINT = 'https://apt.github.com'.freeze
  ACCESS_TOKEN = 'c6ed841aaf0fe3eeab01cfc05e47cff942f62da5'

  def initialize
    @http_client = setup_http_client
  end

  def create_gist(params)
    @http_client.post('gists') do |request|
      request.headers['Authorization'] = "token #{ACCESS_TOKEN}"
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end
