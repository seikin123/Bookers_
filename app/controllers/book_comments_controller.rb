class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.build(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    render :index
    # redirect_to books_path
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id, :user_id)
  end
end
