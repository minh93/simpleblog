class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_entry, only: [:create]
  before_action :can_comment, only: [:create]

  def create
    @entry = Entry.find params[:entry_id]
    @comment = @entry.comments.build comment_param
    if @comment.save
      flash[:success] = "Commented"
      redirect_to @entry.user
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "deleted!"
    redirect_to request.referrer || root_url
  end

  def find_entry
    @entry = Entry.find params[:entry_id]
    redirect_to root_path, flash[:warning] = "Access denied" unless @entry
  end

  def can_comment
    entry_owner = Entry.find(params[:entry_id]).user
    unless current_user.followers.include?(entry_owner) || current_user == entry_owner
      redirect_to entry_owner
      flash[:warning] = "Can not comment here"
    end
  end

  private

  def comment_param
    params.require(:comment).permit(:content, :user_id, :entry_id)
  end
end
