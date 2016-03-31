class Admin::DashboardsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def show
    @dashboard = Dashboard.new	
  end
end