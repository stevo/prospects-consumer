class AddUsersAndDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.boolean :admin, default: false

      t.timestamps
    end

    create_table :documents do |t|
      t.string :title
      t.text :body
      t.integer :document_type, null: false
      t.jsonb :meta
      t.integer :creator_id
      t.integer :prospect_id

      t.timestamps
    end

    add_column :prospects, :owner_id, :integer
  end
end
