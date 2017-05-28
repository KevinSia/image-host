class AddProfileDataToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :username
      t.string :bio
      t.string :website
      t.string :phone
      t.date   :birthday
    end
  end
end
