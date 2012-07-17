class AddFieldsToInterest < ActiveRecord::Migration

  def change
    add_column :interests, :source, :string
    add_column :interests, :url, :string
  end

end
