class CreateClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :description
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
