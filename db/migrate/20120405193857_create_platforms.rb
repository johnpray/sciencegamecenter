class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
