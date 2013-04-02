class CreatePartDescs < ActiveRecord::Migration
  def change
    create_table :part_descs do |t|
      t.string :desc
      t.string :manufac
      t.string :parttype
      t.string :partno

      t.timestamps
    end
  end
end
