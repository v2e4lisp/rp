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

  def class_and_id l, i
    cls = ""
    id = ""

    parts = l.split(" ", 1)
    t1, t2 = parts[0].split("#")
    tmp = t1.split(".")
    tag_name = tmp.shift
    cls << tmp.join(" ").strip if tmp.any?
    if t2
      tmp = t2.split(".")
      id = tmp.shift.strip
      cls << " " << tmp.join(" ").strip if tmp.any?
    end

    l = if parts[1]
          tag_name + " " + parts[1]
        else
          tag_name
        end

    t = ""
    t << "#{INDENT*i}@cls = '#{cls}'\n" if cls.size != 0
    t << "#{INDENT*i}@id = '#{id}'\n"  if id.size != 0
    t << INDENT*i << l
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

      l = class_and_id l, i

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
# print Rp.parse(File.open(File.expand_path("../tmp/test.r")).readlines)
