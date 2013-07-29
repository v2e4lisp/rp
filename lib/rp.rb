require "rp/version"
require "rhtml"

module Rp
  include Rhtml
  extend self

  INDENT_SIZE = 2
  INDENT = " " * INDENT_SIZE

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
      l.chomp!
      next if l.empty?
      i = indent l

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
