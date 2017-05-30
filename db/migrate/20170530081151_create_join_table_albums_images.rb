class CreateJoinTableAlbumsImages < ActiveRecord::Migration[5.0]
  def change
    create_join_table :albums, :posts do |t|
      t.index [:album_id, :post_id]
      t.index [:post_id, :album_id]
    end
  end
end
