# frozen_string_literal: true

class CreateAlbums < ActiveRecord::Migration[7.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.date :album_date

      t.timestamps
    end
  end
end
