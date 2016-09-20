class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :update_total_post_views, only: :show

  #impressionist actions: [:show], unique: [:session_hash]

  layout "editor", only: [:new, :edit, :create, :update]

  def show
    @post = Post.find(params[:id])
    @responses = @post.responses.includes(:user)
    @related_posts = @post.related_posts
    #impressionist(@post)
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != post_path(@post)
      redirect_to @post, status: 301
    end
  end

  def new
    @post = Post.new_draft_for(current_user)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.publish
      redirect_to root_url#, notice: "¡Post creado!"
    else
      @post.unpublish
      flash.now[:alert] = "Algo anda mal. Intenta de nuevo :)"
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)
    if @post.publish
      redirect_to @post#, notice: "¡Post actualizado!"
    else
      @post.unpublish
      flash.now[:alert] = "Algo anda mal. Intenta de nuevo :)"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url#, notice: "Post eliminado"
  end

  # TODO: ideally move this to a separate controller?
  def create_and_edit
    @post = current_user.posts.build(post_params)
    @post.save_as_draft
    redirect_to edit_post_url(@post)
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :all_tags, :picture)
    end

    def authorize_user
      begin
        @post = current_user.posts.find(params[:id])
      rescue
        redirect_to root_url
      end
    end

    def update_total_post_views
      @post = Post.find(params[:id])
      @post.user.update_total_post_views
    end

end