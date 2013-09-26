class AddIndexToBooksIdentifier < ActiveRecord::Migration
  def change
    add_index :books, :identifier, unique: true
  end
end
