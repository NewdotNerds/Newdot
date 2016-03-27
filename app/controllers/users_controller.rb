class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_for_correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_for_relationship, only: [:show]

  def show
  end

  def edit  	
  end

  def update 
    if @user.update(user_params) 	
      redirect_to @user
    else 
      flash.now[:alert] = "Something went wrong. Please try again"
      render :edit
    end
  end

  private

    def check_for_correct_user
      unless current_user.id == params[:id].to_i
        redirect_to root_url
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :avatar, :description)
    end

    #Sets @relationship for Unfollow button
    def check_for_relationship
      if user_signed_in? && current_user.following?(@user)
        @relationship = current_user.active_relationships.find_by(followed_id: @user.id)
      end
    end
end