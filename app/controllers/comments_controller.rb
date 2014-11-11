class CommentsController < ApplicationController
  before_action :signed_in_user

  def index
  	@comments = Comment.all.paginate(page: params[:page])
  end

  def new
  	@comment = Comment.new
  end

  def create
  	@comment = Comment.new(comment_params)
		if @comment.save
			flash[:success] = "Comment successfully posted."
			redirect_to @comment
		else
			render 'new'
		end
  end

  def show
  	@comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
  	if @comment.update_attributes(comment_params)
  		flash[:success] = "Updated successfully."
  		redirect_to @comment
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted."
    redirect_to comments_path
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :company_id)
    end

#  	def observer_user
#  		redirect_to 'show' unless current_user.observer?
#  	end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end

end
