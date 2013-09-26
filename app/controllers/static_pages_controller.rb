class StaticPagesController < ApplicationController
  def intro
  end

  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 5)
      @books = current_user.books.paginate(page: params[:page], :per_page => 10)
      @new_books = my_latest_books_added(current_user)
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
end
