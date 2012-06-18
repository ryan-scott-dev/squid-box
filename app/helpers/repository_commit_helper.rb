module RepositoryCommitHelper

  # remove +/- or wrap in html
  def clean_line(line)
    line.sub(/^./, '').chomp
  end

end