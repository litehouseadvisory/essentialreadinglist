class AddIdentifierTypeToBooks < ActiveRecord::Migration
  def change
    add_column :books, :identifier_type, :string
  end
end
