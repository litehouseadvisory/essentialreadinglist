module SessionsHelper
  
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user =  user
  end
  
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default )
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.url
  end
  
  def amazon_url(isbn)
    link = "unknown"
    begin
      res = Amazon::Ecs.item_lookup(isbn, { :response_group => "Medium"})
      link = res.items[0].get("DetailPageURL") unless res.items.first.nil?
      amazon_url = link.to_s
    rescue
      logger.error "Book unknown on Amazon" 
      flash[:error] = "Sorry, could not find this book on Amazon"
    end
  end
  
  def latest_books_added
    latest_books = Book.order("created_at ASC").first(5)
  end
  
  def my_latest_books_added(user)
    latest_books = user.books.order("created_at ASC").first(5)
  end
  
  def user_stats
    users_count = User.count
  end
  
  def book_stats
    books_count = Book.count
  end
  
  
end
