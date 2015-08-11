require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

module MarkdownHelper

  # Create a Redcarpet Renderer with Rouge code formatting.
  # See: https://github.com/jneen/rouge#you-can-even-use-it-with-redcarpet
  class HTMLwithHighlighting < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown_to_html(markdown)
    @renderer ||=
      Redcarpet::Markdown.new(HTMLwithHighlighting,
                              extensions = {fenced_code_blocks: true})
    @renderer.render(markdown).html_safe
  end
end
