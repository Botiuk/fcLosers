# frozen_string_literal: true

class CreateCoaches < ActiveRecord::Migration[7.2]
  def change
    create_table :coaches do |t|
      t.string :name
      t.string :middle_name
      t.string :surname
      t.date :date_of_birth
      t.integer :which_team
      t.integer :position

      t.timestamps
    end
  end
end
