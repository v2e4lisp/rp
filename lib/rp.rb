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

  def indent_and_ends l,i
    ends @indent-1, @indent-i
    @indent = i
    @doc << "\n#{l}"
  end

  def indent_and_do l,i
    @doc << " do\n#{l}"
    @indent = i
  end

  def indent_line l,i
    if i > @indent
      indent_and_do l,i
    elsif i < @indent
      indent_and_ends l,i
    else
      @doc << "\n#{l}"
    end
  end

  def class_and_id l, i
    cls = ""
    id = ""

    parts = l.split(" ", 2)
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
      else
        l = class_and_id l, i
      end

      indent_line l,i
    end
    ends(@indent-1, @indent)
    @doc
  end

  def to_html lines
    eval(parse(lines))
  end

  def to_rhtml lines
    parse(lines)
  end
end
# puts Rp.to_rhtml(File.open(File.expand_path("../tmp/test1.r")).readlines)
# puts Rp.to_html(File.open(File.expand_path("../tmp/test1.r")).readlines)
