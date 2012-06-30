class RepositoryCommitController < ApplicationController
  def show
    @repository = Repository.find params[:id]
    @commit = @repository.find_commit params[:commit_id]
    @comments = Comment.find_all_by_commit(@commit.id)
  end
end
