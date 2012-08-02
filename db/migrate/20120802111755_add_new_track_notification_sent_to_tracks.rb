class AddNewTrackNotificationSentToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :discovered_at, :datetime
  end
end
