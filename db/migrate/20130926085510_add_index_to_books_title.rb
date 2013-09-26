class AddIndexToBooksTitle < ActiveRecord::Migration
  def change
    add_index :books, :title
  end
end
