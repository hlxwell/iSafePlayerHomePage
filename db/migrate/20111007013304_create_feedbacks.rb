class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.text :content
      t.integer :parent_id

      t.timestamps
    end
  end
end
