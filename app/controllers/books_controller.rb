class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page])
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      flash[:notice] = 'Create book successfully.'
      redirect_to book_path(@book)
    else
      @books = Book.page(params[:page])
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    render :show
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render layout: 'no_left'
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.user != current_user
      return redirect_to books_path
    end

    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit, layout: 'no_left'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user == current_user
      @book.destroy
      flash[:notice] = 'You have deleted book successfully.'
      redirect_to books_path
    else
      flash[:warning] = 'You cannot delete book.'
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
