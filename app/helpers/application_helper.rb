module ApplicationHelper

  def follow_button_for(user)
    if user_signed_in?
      unless current_user?(user)
        react_component('UserFollowButton', { following: current_user.following?(user), followed_id: user.id })
      end
    else
      react_component('UserFollowButton', { isSignedIn: false });
    end
  end

  def follow_tag_button_for(tag)
    if user_signed_in?
      react_component('TagFollowButton', { following: current_user.following_tag?(tag), tag_id: tag.id })
    else
      button_to "Seguir", "", class: 'pull-right button green-border-button follow-button', data: { behavior: 'trigger-overlay' }
    end
  end

  def feature_tag_button_for(tag)
    if tag.featured?
      render partial: 'admin/unfeature_tag_button', locals: { tag: tag }
    else
      render partial: 'admin/feature_tag_button', locals: { tag: tag }
    end
  end

  def feature_post_button_for(post)
    if post.featured?
      render partial: 'admin/unfeature_post_button', locals: { post: post }
    else
      render partial: 'admin/feature_post_button', locals: { post: post }
    end
  end

  def nav_link_to(text, url, options = {})
    options[:class] ||= ""
    options[:class] += " active" if current_page?(url)
    options[:class].strip!
    link_to text, url, options
  end

  def image_link_to(image_path, url, image_tag_options = { }, link_to_options = { })
    link_to url, link_to_options do
      image_tag image_path, image_tag_options
    end
  end

  def randomized_background_image
    images = [("/assets/background/waimea-canyon.jpg"), ("/assets/background/burning-man.jpg"), 
              ("/assets/background/lima-peru.jpg"), ("/assets/background/bridge.jpg"), 
              ("/assets/background/landscape.jpg"), ("/assets/background/volcano.jpg"),
              ("/assets/background/malecon-lima.jpg"), ("/assets/background/sierra-peru.jpg")]
    images[rand(images.size)]
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text.to_s).html_safe
  end

end