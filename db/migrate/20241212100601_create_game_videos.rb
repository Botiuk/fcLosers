# frozen_string_literal: true

class CreateGameVideos < ActiveRecord::Migration[7.2]
  def change
    create_table :game_videos do |t|
      t.references :game, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
