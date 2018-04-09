class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :name
      t.integer :age
      t.integer :rating_1
      t.integer :rating_2
      t.text :comments
      t.boolean :terms_accepted

      t.timestamps
    end
  end
end
