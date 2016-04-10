class Admin::DashboardsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def show
    @dashboard = Dashboard.new(posts: all_posts)
  end

  private

    def all_posts
      Post.all
    end
end