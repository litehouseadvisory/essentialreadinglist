class Comment < ActiveRecord::Base
  belongs_to :book
  validates :book_id, presence: true
  belongs_to :user
end
