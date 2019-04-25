if !defined?(IRB::Irbrc) && RUBY_VERSION >= '2.5.0'
  require 'ripper'

  module IRB::Irbrc
    CLEAR = 0
    BOLD = 1
    UNDERLINE = 4
    RED = 31
    GREEN = 32
    BLUE = 34
    CYAN = 36

    TOKEN_KEYWORDS = {
      on_kw: ['nil', 'self', 'true', 'false'],
      on_const: ['ENV'],
    }

    EXPR_TOKEN_SEQ = {
      Ripper::EXPR_BEG => {
        on_qwords_beg: [RED],
        on_kw: [GREEN],
        on_embexpr_beg: [RED],
        on_tstring_beg: [RED],
        on_tstring_content: [RED],
        on_regexp_beg: [RED],
        on_regexp_end: [RED],
      },
      Ripper::EXPR_END => { # ruby 2.6+
        on_kw: [GREEN],
        on_int: [BLUE, BOLD],
        on_CHAR: [BLUE, BOLD],
        on_embexpr_end: [RED],
        on_tstring_end: [RED],
      },
      (Ripper::EXPR_END|Ripper::EXPR_ENDARG) => { # ruby 2.5
        on_kw: [GREEN],
        on_int: [BLUE, BOLD],
        on_CHAR: [BLUE, BOLD],
        on_embexpr_end: [RED],
        on_tstring_end: [RED],
      },
      Ripper::EXPR_CMDARG => {
        on_tstring_beg: [RED],
        on_tstring_content: [RED],
        on_const: [BLUE, BOLD, UNDERLINE],
      },
      Ripper::EXPR_ARG => {
        on_const: [BLUE, BOLD, UNDERLINE],
      },
      Ripper::EXPR_CLASS => {
        on_kw: [GREEN],
      },
      Ripper::EXPR_FNAME => {
        on_kw: [GREEN],
        on_symbeg: [BLUE],
      },
      (Ripper::EXPR_FNAME|Ripper::EXPR_FITEM) => {
        on_kw: [GREEN],
      },
      Ripper::EXPR_ENDFN => {
        on_ident: [BLUE, BOLD],
        on_embexpr_end: [RED],
      },
      (Ripper::EXPR_BEG|Ripper::EXPR_LABEL) => {
        on_kw: [GREEN],
        on_tstring_beg: [RED],
        on_tstring_content: [RED],
      },
    }

    class << self
      def with_script_lines
        if defined?(SCRIPT_LINES__)
          orig = SCRIPT_LINES__
          Object.class_eval { remove_const(:SCRIPT_LINES__) }
        else
          orig = nil
        end

        script_lines = {}
        Object.const_set(:SCRIPT_LINES__, script_lines)
        begin
          yield(script_lines)
        ensure
          Object.class_eval { remove_const(:SCRIPT_LINES__) }
          Object.const_set(:SCRIPT_LINES__, orig) if orig
        end
      end

      def colorize_code(code)
        colored = ''
        Ripper.lex(code).each do |(_line, _col), token, str, expr|
          if seq = dispatch_seq(token, expr, str)
            colored << "#{seq.map { |s| "\e[#{s}m" }.join('')}#{str}\e[#{CLEAR}m"
          else
            colored << str
          end
        end
        colored
      end

      private

      def dispatch_seq(token, expr, str)
        if token == :on_comment # may leak colors on multi lines
          [BLUE, BOLD]
        elsif TOKEN_KEYWORDS.fetch(token, []).include?(str)
          [CYAN, BOLD]
        elsif seq = EXPR_TOKEN_SEQ.fetch(expr.to_i, {})[token]
          seq
        else
          nil
        end
      end
    end
  end

  IRB::WorkSpace.prepend(Module.new{
    def code_around_binding
      file = @binding.eval('__FILE__')
      result = IRB::Irbrc.with_script_lines do |script_lines|
        script_lines[file] = IRB::Irbrc.colorize_code(File.read(file)).lines
        super
      end
      "#{result.gsub(/^( +(=>)? +)(\d+):/, "\\1\e[#{IRB::Irbrc::BLUE}m\e[#{IRB::Irbrc::BOLD}m\\3\e[#{IRB::Irbrc::CLEAR}m:")}\e[#{IRB::Irbrc::CLEAR}m"
    end
  })
end
