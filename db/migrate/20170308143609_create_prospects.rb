class CreateProspects < ActiveRecord::Migration[5.0]
  def change
    create_table :prospects do |t|
      t.string :name
      t.text :description
      t.jsonb :meta

      t.timestamps
    end
  end
end
