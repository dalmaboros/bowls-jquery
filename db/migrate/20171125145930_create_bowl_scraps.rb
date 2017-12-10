class CreateBowlScraps < ActiveRecord::Migration
  def change
    create_table :bowl_scraps do |t|
      # t.integer :bowl_id
      # t.integer :scrap_id

      t.belongs_to :bowl, index: true, foreign_key: true
      t.belongs_to :scrap, index: true, foreign_key: true

      t.timestamps
    end
  end
end
