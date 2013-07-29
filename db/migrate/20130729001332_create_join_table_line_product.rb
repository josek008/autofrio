class CreateJoinTableLineProduct < ActiveRecord::Migration
	def change
		create_table :lines_products, :id => false do |t|
			t.integer :line_id
			t.integer :product_id
		end

		add_index :lines_products, [:line_id, :product_id]
	end
end
