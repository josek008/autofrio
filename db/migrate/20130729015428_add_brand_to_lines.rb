class AddBrandToLines < ActiveRecord::Migration
  def change
  	add_column :lines, :brand_id, :integer
  end
end
