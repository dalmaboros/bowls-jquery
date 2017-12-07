class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.integer :user_id
      t.string :description
      t.string :category

      t.timestamps null: false
    end
  end
end
