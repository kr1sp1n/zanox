# require 'rubygems'
# require 'rubygems/gem_runner'
# #Gem.manage_gems
# require 'rake/gempackagetask'
require 'rake'

spec = Gem::Specification.new do |s|
    s.platform  =   Gem::Platform::RUBY
    s.name      =   %q{zanox}
    s.version   =   "0.2.1"
    s.authors   =   ["Krispin Schulz"]
    s.homepage  =   %q{http://kr1sp1n.com/}
    s.date      =   %q{2010-05-07}
    s.email     =   %q{krispinone@googlemail.com}
    s.summary   =   %q{One gem to rule the zanox web services.}
    s.description =   %q{The easy way to the zanox web services.}
    s.files     =   FileList['Rakefile', 'zanox.gemspec', 'README.textile', 'lib/**/*', 'test/*', 'spec/*'].to_a
    s.require_paths  =   ["lib"]
    s.rubygems_version = %q{1.3.5}
    s.test_files = Dir.glob("{test, spec}/**/*")
    # include README while generating rdoc
    s.rdoc_options = ["--main", "README.textile"]
    s.has_rdoc  =   true
    s.extra_rdoc_files  =   ["README.textile"]
    s.add_dependency("soap4r",">=1.5.8")
    s.add_dependency("ruby-hmac", ">=0.4.0")
end

# Rake::GemPackageTask.new(spec) do |pkg|
#     pkg.need_tar = true
# end
# 
# task :default => "pkg/#{spec.name}-#{spec.version}.gem" do
#     puts "generated latest version"
# end