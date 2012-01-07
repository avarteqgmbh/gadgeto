# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "gadgeto"
  gem.homepage = "http://github.com/avarteqgmbh/gadgeto"
  gem.license = "MIT"
  gem.summary = %Q{collection of useful code snippets}
  gem.email = "rgogolok@avarteq.de"
  gem.authors = ["Robert Gogolok", "Matthias Zirnstein"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new


task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gadgeto #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
