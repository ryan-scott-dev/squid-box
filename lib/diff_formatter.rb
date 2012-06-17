module DiffFormatter

  def self.render_differences(diff)
    @line_count = 0
    wrap_lines(diff.map { |line| wrap_line(ERB::Util.h(line)) })
  end

  def self.line_number
    "<td class='line-number'>#{@line_count.to_s}</td>"
  end

  def self.wrap_line(line)
    cleaned = clean_line(line)
    output = ""

    output += "<tr>"

    output += line_number

    case line
      when /^(---|\+\+\+|\\\\)/
        output += '    <td class="diff-comment"><span>'  + line.chomp + '</span></td>'
      when /^\+/
        output += '    <td class="ins"><ins>' + cleaned + '</ins></td>'
      when /^-/
        output += '    <td class="del"><del>' + cleaned + '</del></td>'
      when /^ /
        output += '    <td class="unchanged"><span>' + cleaned + '</span></td>'
      when /^@@/
        output += '    <td class="diff-block-info"><span>' + line.chomp + '</span></td>'
    end

    output += "</tr>"

    case line
      when /^-/
      else
        @line_count += 1
    end

    puts "Rendering output #{output}"

    output
  end

  # remove +/- or wrap in html
  def self.clean_line(line)
    line.sub(/^./, '').chomp
  end

  def self.wrap_lines(lines)
    %'<div class="diff">\n  <table>\n#{lines.join("\n")}\n  </table>\n</div>\n'
  end
end