class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :image
      t.references :user, index: true, foreign_key: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
