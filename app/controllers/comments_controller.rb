class CommentsController < ApplicationController

  def new
    @comment = Comment.new

    render :partial => "new"
  end

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end

  def show
  end

  def index
  end
end
