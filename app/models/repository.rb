class Repository < ActiveRecord::Base

  REPO_DIR = "repos"

  def add_remote(name, remote)
    grit.remote_add(name, remote)
  end

  def create_new_repository
    ensure_path_exists(relative_local_path)
    add_remote(:origin, path)
  end

  def fetch_latest
    grit.remote_fetch(:origin)
  end

  def grit
    Grit::Repo.new(relative_local_path, {:is_bare => true})
  end

  def relative_local_path
    Repository.generate_relative_path(local_path)
  end

  def local_path
    Repository.generate_local_path(self.path)
  end

  def self.generate_relative_path(repo_name)
    "./#{generate_local_path(repo_name)}"
  end

  def self.generate_local_path(repo_name)
    "#{REPO_DIR}/#{repo_name}"
  end

  def self.does_reponame_exist(repo_name)
    File.directory?(generate_relative_path(repo_name))
  end

private
  def ensure_path_exists(path)
    FileUtils.mkdir_p path
  end

end
