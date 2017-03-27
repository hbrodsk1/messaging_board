class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save!
      redirect_to @comment.post
    else
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @user = current_user
    @comment = Comment.find(params[:id])
    @comment.author = "#{@user.first_name} #{@user.last_name}"

    if @comment.update(comment_params)
      redirect_to(@comment.post)
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      redirect_to @comment.post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author, :user_id, :post_id)
  end
end
