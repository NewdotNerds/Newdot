class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update]
  def show
    @dashboard = Dashboard.new(user: current_user, posts: tagged_posts, tag: @tag)
    @related_tags = @tag.related_tags    
  end

  def edit

  end

  def update
    if @tag.update(tag_params)
      redirect_to @tag
    else
      render :edit, alert: "No se pudo actualizar. Intenta de nuevo por favor"
    end
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name, :course_image)
    end

    def tagged_posts
      @_tagged_posts ||= Post.tagged_with(@tag.name).published.includes(:user).paginate(page: params[:page])
    end
end