class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.timestamps
    end
    add_foreign_key :albums, :users
    add_index :albums, :user_id, order: :desc
  end
end
