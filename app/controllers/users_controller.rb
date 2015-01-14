class UsersController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user, only: [:index, :destroy, :new]
  before_action :correct_user, only: [:show, :edit, :update]

	def index
    @users = User.search(params[:search], params[:page])
	end

#	def search
#		@users = User.search(params[:q])
#		render "index"
#	end

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
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :id_num, :organization, :password, :password_confirmation, :admin, :regular, :observer)
    end

    # Before actions

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      if current_user?(@user)
      elsif current_user.admin?
      else
          redirect_to root_path
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
