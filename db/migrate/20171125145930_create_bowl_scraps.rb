class CreateBowlScraps < ActiveRecord::Migration
  def change
    create_table :bowl_scraps do |t|
      t.integer :bowl_id
      t.integer :scrap_id

      t.timestamps
    end
  end
end
