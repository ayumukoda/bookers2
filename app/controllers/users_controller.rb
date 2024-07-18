class UsersController < ApplicationController
  
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
end
