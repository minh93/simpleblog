class StaticPagesController < ApplicationController
  def home
    if logged_in
      @entry = current_user.entries.build
      @lastest_entries = []
      followers = current_user.followers
      followers.each do |f|
        if !f.entries.last.nil?
          @lastest_entries<<f.entries.last
        end
      end
    end
  end

  def help
  end
end
