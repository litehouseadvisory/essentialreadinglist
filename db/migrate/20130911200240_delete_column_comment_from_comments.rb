class DeleteColumnCommentFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :comment
  end
end
