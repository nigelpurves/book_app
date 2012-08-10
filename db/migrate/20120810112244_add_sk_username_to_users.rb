class AddSkUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skusername, :string
  end
end
