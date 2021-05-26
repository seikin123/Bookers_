class CreateCommenters < ActiveRecord::Migration[5.2]
  def change
    create_table :commenters do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
