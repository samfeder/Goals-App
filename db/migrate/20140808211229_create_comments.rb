class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :content
      t.references :commentable, polymorphic: true

      t.timestamps
    end

    add_index :comments, :user_id
  end
end
