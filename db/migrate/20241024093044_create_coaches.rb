# frozen_string_literal: true

class CreateCoaches < ActiveRecord::Migration[7.2]
  def change
    create_table :coaches do |t|
      t.string :name, null: false
      t.string :middle_name, null: false
      t.string :surname, null: false
      t.date :date_of_birth, null: false
      t.integer :which_team, null: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
