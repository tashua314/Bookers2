class UsersController < Devise::SessionsController
  def new
    super
    render layout: 'no_left'
  end

  def index
    if not user_signed_in?
      return redirect_to new_user_session_path
    end
    @users = User.page(params[:page]).reverse_order
  end

  def show
    if not user_signed_in?
      return redirect_to new_user_session_path
    end
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    if not user_signed_in?
      return redirect_to new_user_session_path
    end
    @user = User.find(params[:id])
    if @user != current_user
      return redirect_to user_path(current_user)
    end
    render layout: 'no_left'
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
    render :edit, layout: 'no_left'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
