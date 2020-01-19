class AddAttributionTypeToAttributions < ActiveRecord::Migration[5.0]
  def change
    add_column :attributions, :attribution_type, :string
  end
end
