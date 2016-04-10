class SearchController < ApplicationController
  before_action :beautify_url, only: [:show]
  layout "simple"

  def show
    @post_records = Post.search(params[:q]).paginate(page: params[:page]).records
    @posts = @post_records.to_a
    @users = User.search(params[:q]).records.to_a
  end
  
  # GET /autocomplete.json?term=rails
  def autocomplete
    # render json: Post.search(params[:term]).map(&:title)
    @posts = Post.search(params[:term])
    @users = User.search(params[:term])
  end

  private

    def beautify_url
      if params[:search].present?
        redirect_to search_url(q: params[:search][:q])
      end
    end
end