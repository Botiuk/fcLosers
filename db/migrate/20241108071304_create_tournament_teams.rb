# frozen_string_literal: true

class CreateTournamentTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :tournament_teams do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tournament_teams, %i[team_id tournament_id], unique: true
  end
end
