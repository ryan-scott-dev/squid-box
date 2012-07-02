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
    comment = Comment.find(params[:id])

    render :partial => "show", :locals => {:comment => comment}
  end

  def index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    render :nothing => true, :status => :ok
  end
end
