class AddDefaultInterestType < ActiveRecord::Migration
  def up
    connection.execute("UPDATE interests SET type = 'TrackInterest'")
  end

  def down
  end
end
