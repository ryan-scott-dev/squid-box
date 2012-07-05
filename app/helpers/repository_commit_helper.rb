module RepositoryCommitHelper

  # remove +/- or wrap in html
  def clean_line(line)
    line.sub(/^./, '').chomp
  end

  def produce_full_diff(diff)
    produce_diff diff
  end

  private
  def produce_diff(diff, options = {})
    original = diff.a_blob.nil? ? nil : diff.a_blob.data

    Diffy::Diff.new original, diff.b_blob.data, {:allow_empty_diff => true}.merge(options)
  end

end