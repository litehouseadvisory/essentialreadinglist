class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :authors
      t.string :identifier
      t.integer :identifier_type
      t.string :publisher
      t.string :img_url
      t.integer :creator_id

      t.timestamps
    end
  end
end
