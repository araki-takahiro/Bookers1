class UsersController < ApplicationController
  skip_before_action :authenticate_user!,only: [:top,:about]
  before_action :ensure_correct_user,only: [:edit,:update]

  def top
  	if current_user
  		@user = User.find(current_user.id)
  		redirect_to user_path(@user)
  	end
  end

  def about
    if current_user
      @user = User.find(current_user.id)
      redirect_to user_path(@user)
    end
  end

  def index
  	@users = User.all
  	@user = User.find(current_user.id)
  	@book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  end


  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	redirect_to user_path(@user),notice:"successfully"
  	# 投稿一覧
  else
  	render :edit
  end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def ensure_correct_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end

end
