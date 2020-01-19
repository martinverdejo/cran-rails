class CreateVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :versions do |t|
      t.references :package
      t.string :version_number
      t.string :title
      t.string :description
      t.datetime :date_publication

      t.timestamps
    end
  end
end
