module BlogPostsHelper
  def blog_post_preview_image_tag(blog_post)
    return if blog_post.content.blank?

    doc = Nokogiri::HTML(blog_post.content)
    first_img_src = doc.css('img').first&.attr('src')

    return unless first_img_src.present?

    link_to blog_post do
      image_tag(first_img_src, style: "float: right; max-width: 200px; max-height: 98px; margin: 0 5px 5px;")
    end
  end
end
