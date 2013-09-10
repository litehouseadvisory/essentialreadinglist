class Book < ActiveRecord::Base
  belongs_to :user
  
  BOOK_IDENTIFIER_TYPES = ["isbn", "ASIN", "Olid"]
  BOOK_SEARCH_CRITERIA = ["titel", "author", "isbn", "ASIN", "Olid"]
  
  
end
