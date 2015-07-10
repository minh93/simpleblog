class StaticPagesController < ApplicationController
  def home
    if logged_in
      @entry = current_user.entries.build
      @lastest_entries = []
      followers = current_user.followers
      followers.each do |f|
        if !f.entries.first.nil?
          @lastest_entries<<f.entries.first
        end
      end
      @lastest_entries = @lastest_entries.sort_by{|entry| entry.created_at}.reverse.paginate(:page => params[:page] ,:per_page => 3)
    end
  end

  def help
  end
end
