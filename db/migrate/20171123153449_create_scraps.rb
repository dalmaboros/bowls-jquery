class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.string :description
      t.string :category

      t.timestamps null: false
    end
  end
end
