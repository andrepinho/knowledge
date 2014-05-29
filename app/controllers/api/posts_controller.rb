class API::PostsController < ApplicationController
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    respond_with Post.all, meta: { total: Post.count }, meta_key: 'extra'
  end

  def show
    respond_with Post.find(params[:id])
  end

  def create
    # change default posts_url for api_posts_url to work tests
    respond_with Post.create(post_params), location: api_posts_url
  end

  def update
    respond_with Post.update(params[:id], post_params) 
  end

  def destroy
    respond_with Post.destroy(params[:id])
  end

  def not_found
    render json: {errors: "not_found"}, status: 404
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :link)
  end
end
