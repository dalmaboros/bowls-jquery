class CreateBowls < ActiveRecord::Migration
  def change
    create_table :bowls do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
