# frozen_string_literal: true

class CreateGameAlbums < ActiveRecord::Migration[7.2]
  def change
    create_table :game_albums do |t|
      t.references :game, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
