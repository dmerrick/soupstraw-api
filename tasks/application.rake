desc 'Run the app'
task :s do
  system "rackup -p 9595 config.ru"
end
