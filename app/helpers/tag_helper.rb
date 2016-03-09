module TagHelper

  def display_tags_for(taggable)
    taggable_type = taggable.class.name.underscore.to_sym
    draw_tag_markup(tags: taggable.tags, taggable_type: taggable_type)
  end

  private

  def draw_tag_markup(tags:, taggable_type:)
    content_tag(:div, class: 'tags') do
      draw_tags(tags: tags, taggable_type: taggable_type)
    end
  end

  def draw_tags(tags:, taggable_type:)
    rendered_tags = ''

    if tags.any?
      tags.each do |tag|
        rendered_tags << content_tag(:span) do
          draw_tag_url(tag: tag, taggable_type: taggable_type)
        end
      end
    end

    return rendered_tags.html_safe
  end

  def draw_tag_url(tag:, taggable_type:)
    link_to(tag.label, exposition.tag_path(tag, type: taggable_type))
  end
end
