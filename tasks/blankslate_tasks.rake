namespace :blank_slates do
  
  desc 'Generate a blank slate for a controller and a view'
  task :generate do
    if ENV['FOR'].nil?
      puts "USAGE : rake blank_slates:generate FOR='path/to/blank/slate'"
      exit
    else
      blank_slate_ary = File.split ENV['FOR']
      file = blank_slate_ary.last
      
      blank_slate_path = File.join(Rails.root, "app", "views", "blank_slates")
      Dir.mkdir blank_slate_path unless File.exists? blank_slate_path
      
      dir_path = File.join(blank_slate_path, blank_slate_ary.first)
      FileUtils.mkdir_p dir_path unless File.exists? dir_path
      
      file_path = File.join(dir_path, "_#{file}.erb")
      File.open(file_path,"w+") do |file|
        file << "<!-- Here goes the beginning of a great blank slate -->"
      end
      
      puts "Your blank slate has been generated at : #{file_path}"
      system("mate #{file_path}") if system("mate")
    end
  end
  
end
