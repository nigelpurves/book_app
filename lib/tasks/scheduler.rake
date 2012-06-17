desc "This task updates links on songs which need them"
task :update_links => :environment do
    puts "Updating links..."
    Track.update_links
    puts "done"
end