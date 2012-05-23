class Repository < ActiveRecord::Base
  attr_accessible :name, :path

  validates_presence_of :name, :path
  validate :is_path_uri?, :is_path_git_repo?

  def is_path_uri?
    errors.add(:path, "not a valid url") unless Repository.uri?(self.path)
  end

  def is_path_git_repo?
    errors.add(:path, "not a valid git repo") unless Repository.is_git_repo?(self.path)
  end

  private

  def self.is_git_repo?(path)
    repo = Grit::Git.new(path)
    remotes = repo.run('', 'ls-remote "' + path + '"', '', {}, {})
    remotes != ""
  end

  def self.uri?(string)
    uri = URI.parse(string)
    %w( http https git ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end
