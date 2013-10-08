class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :order, :priority
  end
end
