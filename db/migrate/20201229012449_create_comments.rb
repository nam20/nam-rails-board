class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.string :content
      t.integer :group_id
      t.integer :group_order
      t.integer :depth
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
