class CommentsController < ApplicationController

  def new
    @comment = Comment.new

    render :partial => "new"
  end

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      html = render_to_string :partial => "comments/line", :locals => {:comment => @comment}

      render :json => {:success => true, :data => html}
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
