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
    if !text.nil?
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :space_after_headers => true, :hard_wrap => true, :with_toc_data => true)
      sanitize(markdown.render(text))
    else
      ''
    end
  end

  def markdown_inline(text)
    if !text.nil?
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :space_after_headers => true, :hard_wrap => false, :with_toc_data => true)
      sanitize(markdown.render(text), tags: %w(a span b strong i em))
    else
      ''
    end
  end

  # Creates a link that gets tracked in Google Analytics
  def tracked_link_to(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second
      tracked_link_to(capture(&block), options, html_options)
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2]

      html_options = convert_options_to_data_attributes(options, html_options)
      url = url_for(options)

      href = html_options['href']
      tag_options = tag_options(html_options)

      href_attr = "href=\"#{ERB::Util.html_escape(url)}\"" unless href
      "<a #{href_attr}#{tag_options} onClick=\"recordOutboundLink(this, 'Tracked Links', '#{href || ERB::Util.html_escape(url)}');return false;\">#{ERB::Util.html_escape(name || url)}</a>".html_safe
    end
  end

  # Creates a link that gets tracked in Google Analytics
  def confirmed_tracked_link_to(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second
      link_to(capture(&block), options, html_options)
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2]

      html_options = convert_options_to_data_attributes(options, html_options)
      url = url_for(options)

      href = html_options['href']
      tag_options = tag_options(html_options)

      message = "You\\'re about to leave the Science Game Center to visit one of our generous sponsors. Check them out! We hope to see you again soon."

      href_attr = "href=\"#{ERB::Util.html_escape(url)}\"" unless href
      "<a #{href_attr}#{tag_options} onClick=\"if(confirm('#{message}')){recordOutboundLink(this, 'Tracked Links', '#{href || ERB::Util.html_escape(url)}');}return false;\">#{ERB::Util.html_escape(name || url)}</a>".html_safe
    end
  end

  def external_link_icon
    image_tag("external-link-icon.png", alt: "(external)", title: "This link leads to an external website.", style: "display: inline; vertical-align: text-top;").html_safe
  end
end
