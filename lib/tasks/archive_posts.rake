namespace :archive_posts do
  desc "Heroku scheduler tasks"
  task :save_yesterday => :environment do
    ProcessData.new.archive_x_days(1)
  end
end