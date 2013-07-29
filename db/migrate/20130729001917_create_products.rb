class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :comments
      t.string :reference
      t.integer :category_id

      t.timestamps
    end
  end
end
