class BooksController < ApplicationController
  def index
    @book=Book.new
    @books=Book.all
    @user=current_user

  end

  def show
    @books = Book.find(params[:id])
    @book=Book.new
    @user=@books.user


  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def update
   @book = Book.find(params[:id])
   if @book.update(book_params)
     redirect_to book_path(@book.id), notice: "Book was successfully."
   else
     render "edit"
   end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy# データ（レコード）を削除
    flash[:success] = "Book was successfully destroyed."
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  def create
  @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id), notice: "Book was successfully."
    else
     @books=Book.all
     @user=current_user

    render :index
    end
  end

    private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end