class ChangeDatevIdOfParts < ActiveRecord::Migration
  def up
    rename_column :parts, :datevid, :datev_id
  end

  def down
    rename_column :parts, :datev_id, :datevid
  end
end
