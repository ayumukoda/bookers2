class BooksController < ApplicationController
  def new
  end
  
  def create
    @Book = Book.new(book_params)
    Book.save
    redirect_to books_path(@book.id)
  end

  def index
  end

  def show
  end

  def edit
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
