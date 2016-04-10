class DashboardsController < ApplicationController
  before_action :check_for_admin, only: [:show]
  before_action :authenticate_user!, only: [:bookmarks]
  def show
  	if user_signed_in?
  	  @dashboard = Dashboard.new(user: current_user, posts: feed)
  	else
  	  @dashboard = Dashboard.new(posts: recent_posts)
  	end
  end

  def bookmarks
    @dashboard = Dashboard.new(user: current_user, posts: bookmarked_posts, filter: :bookmarks)
    render :show
  end

  def top_stories
    if user_signed_in?
      @dashboard = Dashboard.new(user: current_user, posts: top_posts, filter: :top_stories)
    else
      @dashboard = Dashboard.new(posts: top_posts, filter: :top_stories)
    end
    render :show
  end

  private

    def check_for_admin
      redirect_to admin_dashboard_url if admin_signed_in?
    end

    def feed
      Feed.new(current_user)
    end

    def bookmarked_posts
      current_user.bookmarked_posts
    end

    def top_posts
      Post.top_stories(5)
    end

    def recent_posts
      Post.recent
    end

end