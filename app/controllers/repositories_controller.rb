class RepositoriesController < ApplicationController
  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new(params[:repository])

    if @repository.save()
      redirect_to @repository, :notice => "Repository Created"
    else
      render :new
    end
  end

  def show
  end
end
