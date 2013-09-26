class Book < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :identifier, uniqueness: { case_sensitive: false }
 
  BOOK_IDENTIFIER_TYPES = ["isbn", "ASIN", "Olid"]
  BOOK_SEARCH_CRITERIA = ["titel", "author", "isbn", "ASIN", "Olid"]
  
  def average_rating
    if self.ratings.size > 0
      self.ratings.average(:score).round(0)
    else
      return 0
    end
  end
  
  
  
  #Ruby
  def is_valid?(isbn)
    (isbn.length == 10) && (isbn.split('').inject([10,0]){|a, c| i,s = a; [s+i*c.to_i,i-1]}.first%11==0)
  end
  
end
