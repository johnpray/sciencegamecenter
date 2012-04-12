module ApplicationHelper

	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Science Game Reviews"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :space_after_headers => true, :hard_wrap => true, :with_toc_data => true)
		return sanitize(markdown.render(text))
	end
end
