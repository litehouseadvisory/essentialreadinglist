class RemoveIdentifierTypeFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :identifier_type, :integer
  end
end
