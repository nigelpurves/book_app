class AddTypeToInterests < ActiveRecord::Migration
  def change
    add_column :interests, :type, :string
  end
end
