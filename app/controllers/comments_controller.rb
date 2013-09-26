class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  
  def create
      current_book = Book.find(comment_params[:book_id])
      @comment = current_book.comments.build(comment_params)
      if @comment.save
        flash[:success] = "Your book review was saved!"
        redirect_to current_book
      else
        flash[:error] = "Your book review could not be saved!"
        redirect_to current_book
      end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end
  
  
  private
  
    def comment_params
      params.require(:comment).permit( :comment, :user_id, :book_id)
    end
  
    
end
