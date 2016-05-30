desc "Heroku scheduler tasks"
task :update_database => :environment do
  puts "Saving posts from yesterday."
  Archive.new.archive_yesterday
  puts "Posts Saved!"
end