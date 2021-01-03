class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :image
      t.references :user, index: true, foreign_key: true
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
