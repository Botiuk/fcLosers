# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :surname
      t.date :date_of_birth
      t.integer :which_team
      t.integer :position
      t.integer :player_number
      t.float :height
      t.float :weight
      t.integer :leg

      t.timestamps
    end
  end
end
