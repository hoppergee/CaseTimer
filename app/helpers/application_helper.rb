module ApplicationHelper

	def markdown(text)
		
		renderer_options = {
			hard_wrap: true,
			filter_html: true
		}

		markdown_options = {
			autolink: true,
			no_intra_emphasis: true,
			fenced_code_blocks: true,
			lax_html_blocks: true,
			strikethrough: true,
			superscript: true
		}

		renderer = HTMLwithRouge.new(renderer_options)
		Redcarpet::Markdown.new(renderer, markdown_options).render(text).html_safe

	end

	class HTMLwithRouge < Redcarpet::Render::HTML
		
		INDENT = " " * 2

		def block_code(code, metadata)
			language, filename = metadata.split(":") if metadata

			lexer = find_lexer_with(language)

			formatter = Rouge::Formatters::HTML.new
			formatter1 = Rouge::Formatters::HTMLPygments.new(formatter, css_class='')
			formatter2 = Rouge::Formatters::HTMLTable.new(formatter, opts={})

			rows = []
			rows << %(<div class="code-block">)
			if filename
				rows << %(#{INDENT}<div class="code-header">)
				rows << %(#{INDENT * 2}<span>#{filename}</span>)
				rows << %(#{INDENT}</div>)
			else
				rows << %(#{INDENT}<div class="code-header">)
				rows << %(#{INDENT * 2}<span>&nbsp</span>)
				rows << %(#{INDENT}</div>)
			end
			rows << %(#{INDENT}<div class="code-body">)
			rows << %(#{INDENT * 2}#{formatter2.format(lexer.lex(code))})
			rows << %(#{INDENT}</div>)
			rows << %(</div>)
			rows.join("\n")
		end

		def find_lexer_with(language)
			if language
				case language.downcase
				when "rb", "ruby"
					lexer = DiffRuby
				when "html"
					lexer = DiffHTML
				when "erb"
					lexer = DiffErb
				when "js", "javascript"
					lexer = DiffJS
				else
					lexer = Rouge::Lexer.find(language.downcase) || lexer = Rouge::Lexers::PlainText
				end
			else
				lexer = Rouge::Lexers::PlainText
			end
		end
	end

	class DiffRuby < Rouge::Lexers::Ruby
		prepend :root do
			rule(/^\+.*$\n?/, Generic::Inserted)
			rule(/^-+.*$\n?/, Generic::Deleted)
		end
	end

	class DiffHTML < Rouge::Lexers::HTML
		prepend :root do
			rule(/^\+.*$\n?/, Generic::Inserted)
			rule(/^-+.*$\n?/, Generic::Deleted)
		end
	end

	class DiffErb < Rouge::Lexers::ERB
		prepend :root do
			rule(/^\+.*$\n?/, Generic::Inserted)
			rule(/^-+.*$\n?/, Generic::Deleted)
		end
	end

	class DiffJS < Rouge::Lexers::Javascript
		prepend :root do
			rule(/^\+.*$\n?/, Generic::Inserted)
			rule(/^-+.*$\n?/, Generic::Deleted)
		end
	end

	class DiffCoffee < Rouge::Lexers::Coffeescript
		prepend :root do
			rule(/^\+.*$\n?/, Generic::Inserted)
			rule(/^-+.*$\n?/, Generic::Deleted)
		end
	end

  	def humanize(secs)
  		if secs == 0
			"0秒"
		else
			[[60, "秒"], [60, "分"], [24, "小时"], [1000, "天"]].map{|count, name|
				if secs > 0
					secs, n = secs.divmod(count)
					"#{n.to_i}#{name}"
				end
			}.compact.reverse.join(' ')
		end
	end

end
