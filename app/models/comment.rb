class Comment < ActiveRecord::Base
  belongs_to :book
  default_scope -> { order('created_at DESC')}
  validates :book_id, presence: true
  belongs_to :user
  validates :comment, presence: true
  validates :user_id, presence: true
end
