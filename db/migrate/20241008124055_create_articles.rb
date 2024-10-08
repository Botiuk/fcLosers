# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :article_type
      t.datetime :published_at

      t.timestamps
    end
  end
end
