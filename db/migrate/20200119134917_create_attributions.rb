class CreateAttributions < ActiveRecord::Migration[5.0]
  def change
    create_table :attributions do |t|
      t.references :person, foreign_key: true
      t.references :version, foreign_key: true

      t.timestamps
    end
  end
end
