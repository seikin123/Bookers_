class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :editing_user, only: [:edit]

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @books = Book.search(params[:search])
  end

  def create
    @booknew = Book.new(book_params) 
    @booknew.user_id =  current_user.id 
    @user = current_user
  if @booknew.save 
    redirect_to book_path(@booknew.id), notice: 'Book was successfully created'  
  else
    @books = Book.all
    render :index
  end
end

  def index
    @books = Book.all
    @booknew = Book.new
    @user = current_user
    
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully updated!'
    else
      
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def editing_user
    book = Book.find(params[:id])
    if book.user != current_user 
      redirect_to books_path
    end
  end
end
