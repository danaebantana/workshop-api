class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end
  
  # Return data for the specific page
  def hobby
    posts_for_branch(params[:action])
  end

  def study
    posts_for_branch(params[:action])
  end

  def team
    posts_for_branch(params[:action])
  end

  private

  # Return data for the specific page, depending on the action’s name
  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = get_posts.paginate(page: params[:page])
  end

  def get_posts
    PostsForBranchService.new({
      search: params[:search],
      category: params[:category],
      branch: params[:action]
    }).call
  end
end
