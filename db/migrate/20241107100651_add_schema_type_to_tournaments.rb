# frozen_string_literal: true

class AddSchemaTypeToTournaments < ActiveRecord::Migration[7.2]
  def change
    add_column :tournaments, :schema_type, :integer
  end
end
