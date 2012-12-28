class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :desc, :limit => 80
      t.string :serial, :limit => 32
      t.decimal :price, :precision => 10, :scale => 2
      t.integer :datevid

      t.timestamps
    end
  end
end
