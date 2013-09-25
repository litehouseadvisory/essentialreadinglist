class Book < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :ratings
  validates :title, presence: true
  
  BOOK_IDENTIFIER_TYPES = ["isbn", "ASIN", "Olid"]
  BOOK_SEARCH_CRITERIA = ["titel", "author", "isbn", "ASIN", "Olid"]
  
  def average_rating
    ratings.average(:score).round(0)
  end
  
  
  
  #Ruby
  def is_valid?(isbn)
    (isbn.length == 10) && (isbn.split('').inject([10,0]){|a, c| i,s = a; [s+i*c.to_i,i-1]}.first%11==0)
  end
  
end
