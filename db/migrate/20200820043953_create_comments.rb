class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :band_id
      t.integer :user_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
