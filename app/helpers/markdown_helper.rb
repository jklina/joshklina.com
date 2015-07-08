require 'redcarpet'

module MarkdownHelper

  def markdown_to_html(markdown)
    @renderer_engine ||= Redcarpet::Render::HTML.new()
    @renderer ||= Redcarpet::Markdown.new(@renderer_engine, extensions = {})

    @renderer.render(markdown).html_safe
  end
end
