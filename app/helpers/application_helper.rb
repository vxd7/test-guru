module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, project_name)
    link_to(project_name, "http://github.com/#{author}/#{project_name}")
  end

  def flash_message(msg_level)
    content_tag(:p, flash[msg_level], class: 'flash alert') if flash[msg_level]
  end
end
