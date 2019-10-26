module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, project_name)
    link_to(project_name, "http://github.com/#{author}/#{project_name}")
  end
end
