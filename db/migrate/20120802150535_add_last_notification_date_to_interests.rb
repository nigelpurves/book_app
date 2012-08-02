class AddLastNotificationDateToInterests < ActiveRecord::Migration
  def change
    add_column :interests, :last_notified_at, :datetime
  end
end
