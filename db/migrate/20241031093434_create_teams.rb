# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :team_type
      t.string :name, null: false
      t.string :represent, null: false

      t.timestamps
    end
    add_index :teams, %i[name team_type represent], unique: true
  end
end
