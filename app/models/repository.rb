class Repository < ActiveRecord::Base
  attr_accessible :name, :path

  validates_presence_of :name, :path
end
