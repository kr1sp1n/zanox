task :default => [:test]
 
$gem_name = "zanox"
 
desc "Test the library"
task :test do
  ruby Dir.glob("test/*")
end
 
desc "Run specs" 
task :spec do
  sh "spec spec/* --format specdoc --color"
end
 
desc "Build the gem"
task :build do
  sh "gem build #$gem_name.gemspec"
  sh "mv #$gem_name*.gem ./pkg"
end
 
desc "Install the library at local machine"
task :install => :build do 
  sh "sudo gem install ./pkg/#$gem_name -l"
end
 
desc "Uninstall the library from local machine"
task :uninstall do
  sh "sudo gem uninstall #$gem_name"
end
 
desc "Reinstall the library in the local machine"
task :reinstall => [:uninstall, :install] do
end
 
desc "Clean"
task :clean do
  # sh "rm #$gem_name*.gem" 
end