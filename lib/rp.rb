require "rp/version"
require "rhtml"

module Rp
  include Rhtml
  extend self

  INDENT_SIZE = 2
  INDENT = " " * INDENT_SIZE
  CODE_MARK = ">>"

  def indent(line)
    (line.size - line.lstrip.size)/INDENT_SIZE
  end

  def ends s, n=0
    n.times {|i| @doc << "\n" << INDENT*(s-i) << "end"} if s >= 0
  end

  def parse(lines)
    @doc = ""
    @indent = 0
    lines.each do |l|
      i = indent l
      l.strip!
      next if l.empty?

      if l[0..1] == CODE_MARK
        l.gsub!(/#{CODE_MARK} */, INDENT * i)
        @doc << "\n#{l}"
        next
      end

      if i > @indent
        # do
        @doc << " do\n" << l
        @indent = i
      elsif i < @indent
        # end
        ends @indent-1, @indent-i
        @indent = i
        @doc << "\n" << l
      else
        @doc << "\n" << l
      end
    end

    ends(@indent-1, @indent)
    eval(@doc)
  end
end
