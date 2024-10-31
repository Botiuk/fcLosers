# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :team_type
      t.string :name
      t.string :represent

      t.timestamps
    end
  end
end
