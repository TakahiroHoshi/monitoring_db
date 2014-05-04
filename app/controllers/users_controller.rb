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

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Monitoring DB"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :id_num, :organization, :password, :password_confirmation)
    end

end
