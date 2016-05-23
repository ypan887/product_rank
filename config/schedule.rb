every 1.day, :at => '0:30 am' do
  runner "Archive.new.archive_yesterday"
end