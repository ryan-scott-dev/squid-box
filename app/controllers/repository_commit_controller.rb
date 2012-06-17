class RepositoryCommitController < ApplicationController
  def show
    @repository = Repository.find params[:id]
    @commit = @repository.find_commit params[:commit_id]
  end
end
