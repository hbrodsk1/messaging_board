class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 3).order('updated_at DESC')
	end

	def new
		@post = Post.new
	end

	def create
		@user = current_user
		@post = @user.posts.build(post_params)
		@post.author = "#{@user.first_name} #{@user.last_name}"

		if @post.save
			flash[:notice] = "Post Created"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			flash[:notice] = "Post Updated"
			redirect_to(@post)
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])

		if @post.destroy
			flash[:notice] = "Post Deleted"
			redirect_to @post.user
		end
	end

	private

	def post_params
		params.require(:post).permit(:title, :body, :author, :user_id)
	end
end
