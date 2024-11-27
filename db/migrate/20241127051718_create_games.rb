# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.references :tournament, null: false, foreign_key: true
      t.integer :game_type, null: false
      t.string :stage
      t.references :stadium, null: false, foreign_key: true
      t.date :game_date
      t.time :start_time
      t.references :home_team, null: false
      t.integer :home_goal
      t.references :visitor_team, null: false
      t.integer :visitor_goal

      t.timestamps
    end
    add_foreign_key :games, :teams, column: :home_team_id
    add_foreign_key :games, :teams, column: :visitor_team_id
  end
end
