class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    render layout: 'no_left'
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
