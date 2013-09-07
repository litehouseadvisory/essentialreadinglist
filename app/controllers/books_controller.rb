class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "A new book is added to the GWERL"
      redirect_to books_path
    else
      render :new
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "Book deleted."
      redirect_to books_url
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] =  "Book updated"
      redirect_to @book
    else
      render 'edit'
    end
  end
  
  def search
    isbn = params[:q]
    book_details =  lookup_book_via_isbn(isbn)
    if book_details.nil?
      flash[:error] = "Nothing found"
      redirect_to new_book_path
    else
      author, publisher, isbn = "unknown "
      author = book_details.authors.first["name"] unless book_details.authors.nil?
      if !book_details.publishers.nil?
        publisher = book_details.publishers[0]["name"]
      end
      if !book_details.identifiers.nil?
        isbn_10 = book_details.identifiers["isbn_10"].to_s[2..11]
      end
      identifier_type = "isbn_10"
      img_url = "http://static6.businessinsider.com/image/51c3212a6bb3f79c2000000f/this-space-picture-changes-our-understanding-of-how-black-holes-form.jpg"
      amazon_url = amazon_url(isbn_10)
      book_params = {:title => book_details.title, :authors => author, :publisher => publisher, :identifier => isbn_10, :identifier_type => identifier_type, :img_url => img_url } 
      @book = Book.new(book_params)
      render 'new'
    end
  end
    
  def lookup_book_via_isbn(isbn)
    data = Openlibrary::Data
    book_details = data.find_by_isbn(isbn)
  end
  
  private
  
  def book_params
    params.require(:book).permit( :title, :authors, :publisher, :identifier, :identifier_type, :creator_id, :img_url  )
  end
end
