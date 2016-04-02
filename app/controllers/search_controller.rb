class SearchController < ApplicationController
  def search
    @posts = Post.search(params[:search][:q]).records.to_a
    @search_results = Elasticsearch::Model.search(params[:search][:q], [Post, User]).records.to_a
  end
end