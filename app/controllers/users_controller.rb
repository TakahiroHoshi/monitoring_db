class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.all.order("id")
	end

  def show
    @user = User.find(params[:id])
  end

	def search
		@users = User.search(params[:q])
		render "index"
	end

  def new
    @user = User.new
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

    #Before Actions

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path
        flash[:notice] = "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
