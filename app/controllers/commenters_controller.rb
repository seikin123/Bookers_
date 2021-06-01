class CommentersController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.commenters.new(commenter_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to request.referer, notice: 'successfully created!'
    else
      # @comments = @book.comments
      redirect_to book_path(@book)
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = Commenter.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private

  def commenter_params
    params.require(:commenter).permit(:comment)
  end
end
