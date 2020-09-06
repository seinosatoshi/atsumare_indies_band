class CreateYells < ActiveRecord::Migration[5.2]
  def change
    create_table :yells do |t|
      t.integer :band_id
      t.integer :user_id
      t.datetime :yelled_at

      t.timestamps
    end
  end
end
