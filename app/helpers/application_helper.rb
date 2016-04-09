module ApplicationHelper
  
  def follow_button_for(user)
  	if user_signed_in?
  	  unless current_user?(user)
  	    if current_user.following?(user)
  	  	  render partial: 'shared/unfollow_button', locals: { user: user }
  	  	else
  	  	  render partial: 'shared/follow_button', locals: { user: user }
  	  	end
  	  end
  	else
  	  render partial: 'shared/follow_button', locals: { user: user }
    end
  end

  def follow_tag_button_for(tag)
    if user_signed_in?
      if current_user.following_tag?(tag)
        render partial: 'shared/unfollow_tag_button', locals: { tag: tag }
      else
        render partial: 'shared/follow_tag_button', locals: { tag: tag }
      end
    else
      render partial: 'shared/follow_tag_button', locals: { tag: tag }
    end
  end

  def feature_tag_button_for(tag)
    if tag.featured?
      render partial: 'admin/unfeature_tag_button', locals: { tag: tag }
    else
      render partial: 'admin/feature_tag_button', locals: { tag: tag }
    end
  end

  def nav_link_to(text, url, options = {})
    options[:class] ||= ""
    options[:class] += " active" if current_page?(url)
    options[:class].strip!
    link_to text, url, options
  end

  def markdown(text)
    @renderer ||= Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    @markdown_parser ||= Redcarpet::Markdown.new(@renderer, autolink: true, no_intra_emphasi: true)
    @markdown_parser.render(text).html_safe
  end
end