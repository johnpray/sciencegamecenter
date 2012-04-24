module ApplicationHelper

	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "The Science Game Center"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :space_after_headers => true, :hard_wrap => true, :with_toc_data => true)
    if !text.nil?
		  sanitize(markdown.render(text))
    else
      ""
    end
	end

  def markdown_inline(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :space_after_headers => true, :hard_wrap => true, :with_toc_data => true)
    if !text.nil?
      sanitize(markdown.render(text), tags: %w(a span b strong i em))
    else
      ""
    end
  end
end
