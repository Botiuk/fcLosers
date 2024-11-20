# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.date :date_of_birth, null: false
      t.integer :which_team, null: false
      t.integer :position, null: false
      t.integer :player_number, null: false
      t.float :height, null: false
      t.float :weight, null: false
      t.integer :leg, null: false

      t.timestamps
    end
    add_index :players, %i[player_number which_team], unique: true
  end
end
