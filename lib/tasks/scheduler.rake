desc "Heroku scheduler tasks"
task :archive_yesterday => :environment do
  puts "Saving posts from yesterday."
  Archive.new.archive_yesterday
  puts "Posts Saved!"
end