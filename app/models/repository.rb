require 'fileutils'

class Repository < ActiveRecord::Base
  attr_accessible :name, :path

  validates_presence_of :name, :path
  validate :is_path_uri?, :is_path_git_repo?

  after_save :ensure_repository_exists

  def is_path_uri?
    errors.add(:path, "not a valid url") unless Repository.uri?(self.path)
  end

  def is_path_git_repo?
    errors.add(:path, "not a valid git repo") unless Repository.is_git_repo?(self.path)
  end

  def generate_local_path
    "./repos/#{id}"
  end

  def description
    repo.description
  end

  def ensure_repository_exists
    if File.directory? generate_local_path
      return if repo.config["remote.origin.url"] == path

      FileUtils.rm_rf generate_local_path
    end

    Dir.mkdir generate_local_path

    remote_repo.clone({}, path, generate_local_path)

    self.has_local_clone = true

  end

  def commits(offset = 0, per_page = 10)
    repo.commits('master', per_page, offset * per_page)
  end

  def total_commits
    repo.commit_count
  end

  def find_commit(commit_id)
    repo.commit(commit_id)
  end

  private

  def repo
    @repo ||= Grit::Repo.new(generate_local_path)
  end

  def remote_repo
    @remote_repo ||= Grit::Git.new(path)
  end

  def self.is_git_repo?(path)
    remotes = Grit::Git.new(path).run('', 'ls-remote "' + path + '"', '', {}, {})
    remotes.present?
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
