class UsersController < ApplicationController
	def index
		@users = User.order("id")
	end

	def search
		@users = User.search(params[:q])
		render "index"
	end

  def new
    @user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :id_num, :organization, :password, :password_confirmation)
    end

end
