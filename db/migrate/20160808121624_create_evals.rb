class CreateEvals < ActiveRecord::Migration
  def change
    create_table :evals do |t|
      t.integer :code
      t.string :room

      t.timestamps null: false
    end
  end
end