class UpdateNotificationValues < ActiveRecord::Migration
  def up
    connection.execute "update tracks set discovered_at = now() - interval '1 week'"
    connection.execute "update interests set last_notified_at = now()"
  end

  def down
    connection.execute "update tracks set discovered_at = null"
    connection.execute "update interests set last_notified_at = null"
  end
end
