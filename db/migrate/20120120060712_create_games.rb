class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.string :url
      t.boolean :my_turn, :default => false
      t.datetime :ended_at

      t.timestamps
    end
  end
end
