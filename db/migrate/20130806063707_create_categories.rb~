class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :alias
      t.timestamps
    end
    add_index :categories, :alias
  end
end
