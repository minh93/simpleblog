class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_entry

  def create
    @entry = Entry.find params[:entry_id]
    @comment = @entry.comments.build comment_param
    if @comment.save
      flash[:success] = "Commented"
      redirect_to current_user
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def find_entry
    @entry = Entry.find params[:entry_id]
    redirect_to root_path, flash[:warning] = "Access denied" unless @entry
  end

  private

  def comment_param
    params.require(:comment).permit(:content, :user_id, :entry_id)
  end
end
