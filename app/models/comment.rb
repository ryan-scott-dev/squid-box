class Comment < ActiveRecord::Base
  attr_accessible :content, :start_line, :end_line, :file, :commit, :repository_id, :commit

  def line_length
    end_line - start_line
  end
end
