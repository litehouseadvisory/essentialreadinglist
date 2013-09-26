class AddIndexToBooksAuthors < ActiveRecord::Migration
  def change
    add_index :books, :authors
  end
end
