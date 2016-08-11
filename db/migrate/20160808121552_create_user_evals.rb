class CreateUserEvals < ActiveRecord::Migration
  def change
    create_table :user_evals do |t|
      t.integer :answer_a
      t.integer :answer_b
      t.integer :answer_c
      t.integer :answer_d
      t.integer :answer_e
      t.integer :user_id
      t.integer :eval_id
      t.integer :timeslot

      t.timestamps null: false
    end
  end
end
