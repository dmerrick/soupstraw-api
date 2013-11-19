desc 'Run the app'
task :s do
  system "rackup -p 9393 config.ru"
end
