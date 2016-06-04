module PostsHelper
  def post_length_in_minutes(body)
    min = body.split(" ").size / 250
    if min == 0
      '1 min lectura'
    else
      "#{min} min de lectura"
    end
  end

  def remove_script_tag(html)
    html.gsub(/<script.*?>[\s\S]*<\/script>/i, "")
  end
end