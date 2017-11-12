module ApplicationHelper
  def title(page_title)
    content_for :title, strip_tags(page_title.to_s)
    page_title
  end

  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    @markdown.render(content)
  end

  def admin?
    current_supporter && current_supporter.admin?
  end
end
