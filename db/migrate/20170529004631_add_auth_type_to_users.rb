class AddAuthTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.integer :authentication_type, null: false, default: 0
    end
  end
end
