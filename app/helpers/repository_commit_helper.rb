module RepositoryCommitHelper

  # remove +/- or wrap in html
  def clean_line(line)
    line.sub(/^./, '').chomp
  end

  def produce_full_unified_diff(diff)
    produce_diff diff
  end

  def produce_context_unified_diff(diff)
    produce_diff diff, {:diff => %W(-U 10), :include_diff_info => true}
  end

  def find_line_type(line)
    case line
      when /^(---|\+\+\+|\\\\)/
        :comment
      when /^\+/
        :added
      when /^-/
        :deleted
      when /^ /
        :unchanged
      when /^@@/
        :block_info
      else
        :unknown
    end
  end

  def before_start_line(line)
    line.match(/@@ -(\d+).*\+(\d+),.*/)[1].to_i
  end

  def after_start_line(line)
    line.match(/@@ -(\d+).*\+(\d+),.*/)[2].to_i
  end

  private
  def produce_diff(diff, options = {})
    original = diff.a_blob.nil? ? nil : diff.a_blob.data
    changed = diff.b_blob.nil? ? nil : diff.b_blob.data

    Diffy::Diff.new original, changed, {:allow_empty_diff => true}.merge(options)
  end

end