class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_new_book, if: :user_signed_in?

  def set_new_book
    @book = Book.new
  end

  def after_sign_in_path_for(resource)
    books_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
