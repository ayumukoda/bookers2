class BooksController < ApplicationController
  
  before_action :authenticate_user!#ログインしていなければログインページにリダイレクトする
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
        redirect_to book_path(@book.id), notice: 'book was successfully created'
    else
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
    if @book.user == current_user #urlの入力で画面に飛ばせない
      render "edit"
    else
      redirect_to root_path#indexページにもどす
    end
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
end
