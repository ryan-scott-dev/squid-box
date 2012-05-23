class Repository < ActiveRecord::Base
  attr_accessible :name, :path

  validates_presence_of :name, :path
  validate :is_path_uri?

  def is_path_uri?
    errors.add(:path, "not a valid url") unless Repository.uri?(self.path)
  end

  private

  def self.uri?(string)
    uri = URI.parse(string)
    %w( http https git ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end
