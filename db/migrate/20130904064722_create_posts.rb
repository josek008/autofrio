class CreateNews < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :message
      t.integer :order

      t.timestamps
    end
  end
end
