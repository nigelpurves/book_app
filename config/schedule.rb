# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "~/sites/qusic.co.uk/shared/log/scheduler.log"
#
every 4.hours do
  #command "/usr/bin/some_great_command"
  runner "Track.update_links"
  #rake "some:great:rake:task"
end

every 24.hours do
  #command "/usr/bin/some_great_command"
  runner "Artist.update_catalogue"
#  runner "ArtistInterest.notify_all_users"
  #rake "some:great:rake:task"
end

#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
