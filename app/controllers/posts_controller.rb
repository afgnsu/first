class PostsController < ApplicationController
  before_action :authenticate_user

	def index
		#@posts = Post.all
    #分頁
    #@posts = Post.all.page(params[:page])
    @posts = current_user.posts.page(params[:page]).order('created_at DESC')
		@post = current_user.posts.build
	end

  def create
  	@post = current_user.posts.build(create_params)
  	if @post.save
  		flash[:success] = "新增文章成功！"
  		redirect_to posts_path
  	else
  		render "new"
  	end
  end

  def destroy
  	@post = current_user.posts.find_by(id: params[:id])
  	if @post
	  	@post.destroy
	  	flash[:success] = "文章已刪除！"
	  else
	  	flash[:error] = "無法刪除該文章！"
	  end
  	redirect_to posts_path
  end

  private

  def create_params
  	params.require(:post).permit(:content)
  end
end
