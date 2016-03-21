class HomesController < ApplicationController
  def show
    @posts = Post.all
  end
end