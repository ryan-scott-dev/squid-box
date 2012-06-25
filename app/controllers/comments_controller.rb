class CommentsController < ApplicationController
  def new
    @comment = Comment.new

    render :partial => "new"
  end

  def create
  end

  def show
  end

  def index
  end
end
