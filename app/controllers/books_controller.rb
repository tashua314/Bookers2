class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page])
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to books_path
    else
      render :index
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
