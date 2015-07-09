class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @entry = current_user.entries.build micropost_params
    if @entry.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    Entry.find(params[:id]).destroy
    flash[:success] = "Post deleted!"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:entry).permit :content, :picture
  end

  def correct_user
    @entry = current_user.entries.find_by id: params[:id]
    redirect_to root_url if @entry.nil?
  end
end
