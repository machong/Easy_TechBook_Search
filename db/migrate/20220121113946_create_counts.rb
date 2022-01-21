class CreateCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :counts do |t|
      t.integer :id
      t.string :keyword
      t.integer :count

      t.timestamps
    end
  end
end
