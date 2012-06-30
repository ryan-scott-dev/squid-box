class Comment < ActiveRecord::Base
  attr_accessible :content, :start_line, :end_line, :file, :commit, :repository_id, :commit
  before_create :set_colour

  def line_length
    end_line - start_line
  end

  def set_colour
    self.colour = "%06x" % (rand * 0xffffff)
  end
end
