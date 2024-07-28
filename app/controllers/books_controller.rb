class BooksController < ApplicationController
  
  before_action :authenticate_user!#ログインしていなければログインページにリダイレクトする
  before_action :is_matching_login_user, only: [:edit]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
        redirect_to book_path(@book.id), notice: 'book was successfully created'
    else
      @books = Book.all
      render "index"#indexページに戻す
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @a = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end
  
   def update
        @book = Book.find(params[:id])
        @book.user_id = current_user.id
        if @book.update(book_params)
           redirect_to book_path(@book), notice: 'You have updated book successfully.'#投稿が成功したら表示
        else
           render "edit"
        end
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
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
