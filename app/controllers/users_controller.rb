class UsersController < ApplicationController
  
  before_action :authenticate_user!#ログインしていなければログインページにリダイレクトする
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end
  
  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user#urlの入力で画面に飛ばせない
      render "edit"
    else
      redirect_to user_path(current_user)#userのshowページにもどす
    end
  end
  
  def update
        @user = User.find(params[:id])#ユーザーの取得
        @user.id = current_user.id#ユーザーidがログインしているユーザーであることの確認
        if @user.update(user_params)#updateの保存
          redirect_to user_path(@user.id), notice: 'You have updated user successfully.'#user/idユーザーのshow
        else
          render "edit"
        end
  end
   
   def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
   end
  
end
