class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.boolean :public,  default: true
      t.timestamps
    end

    add_index :goals, :user_id
  end
end
