require 'rbconfig'
include Config

task :default => [:test]

case CONFIG['host_os']
  when /mswin|windows/i
    # Windows
    $windows = true
  when /linux/i
    # Linux
    $linux = true
  when /sunos|solaris/i
    # Solaris
    $solaris = true
  else
    # Whatever
    $mac = true
end
 
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
  if windows?
    sh "move /Y *.gem ./pkg"
  else
    sh "mv #$gem_name*.gem ./pkg"
  end
end
 
desc "Install the library at local machine"
task :install => :build do
  if windows?
    sh "gem install ./pkg/#$gem_name -l"
  else
    sh "sudo gem install ./pkg/#$gem_name -l"
  end
end
 
desc "Uninstall the library from local machine"
task :uninstall do
  if windows?
    sh "gem uninstall #$gem_name"  
  else
    sh "sudo gem uninstall #$gem_name"
  end
end
 
desc "Reinstall the library in the local machine"
task :reinstall => [:uninstall, :install] do
end
 
desc "Clean"
task :clean do
  # sh "rm #$gem_name*.gem" 
end

def windows?
  !!$windows
end