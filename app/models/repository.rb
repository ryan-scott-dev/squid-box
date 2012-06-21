require 'fileutils'

class Repository < ActiveRecord::Base
  attr_accessible :name, :path, :private

  validates_presence_of :name, :path

  before_save :generate_ssh_keys
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

  def generate_ssh_keys
    return unless self.private?
    return if self.public_key.present? && self.private_key.present?

    key = SSHKey.generate

    self.private_key = key.private_key
    self.public_key = key.ssh_public_key
  end

  def ensure_repository_exists
    if File.directory? generate_local_path
      begin
        if repo.config["remote.origin.url"] == path
          self.has_local_clone = true
          return
        end
      rescue
      end

      FileUtils.rm_rf generate_local_path
    end

    Dir.mkdir "./repos" unless File.directory? "./repos"
    Dir.mkdir generate_local_path unless File.directory? generate_local_path

    Dir.mkdir "./keys" unless File.directory? "./keys"
    Dir.mkdir "./keys/#{id}" unless File.directory? "./keys/#{id}"

    File.open(private_key_path, "w") do |private_key_file|
      private_key_file << private_key
    end
    File.chmod 0600, private_key_path

    self.is_cloning = true

    begin
      clone
    rescue
    end

    self.is_cloning = false

    begin
      self.has_local_clone = false

      repo.present?

      self.has_local_clone = true
    rescue
    end

  end

  def private_key_path
    "./keys/#{id}/private_key"
  end

  def clone
    clone_command = "git clone #{path} #{generate_local_path}"
    final_command = clone_command
    if self.private?
      final_command = "ssh-agent bash -c 'ssh-add -D; ssh-add #{private_key_path}; #{clone_command}'"
    end

    puts final_command
    system final_command
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
