class CommentsController < ApplicationController
  
  def create
      current_book = Book.find(comment_params[:book_id])
      @comment = current_book.comments.build(comment_params)
      if @comment.save
        flash[:success] = "Your book review was saved!"
        redirect_to current_book
      else
        redirect_to current_book
      end
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :book_id)
    end
  
end
