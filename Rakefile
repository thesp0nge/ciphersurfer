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

require 'jeweler'
require './lib/ciphersurfer/version'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "ciphersurfer"
  gem.homepage = "http://github.com/thesp0nge/ciphersurfer"
  gem.license = "BSD"
  gem.version = Ciphersurfer::Version::STRING 
  File.open('VERSION', 'w') {|f| f.write(Ciphersurfer::Version::STRING) }

  gem.summary = %Q{evaluates web server SSL configuration}
  gem.description = %Q{ciphersurfer is a security tool that evaluates web server SSL configuration}
  gem.email = "thesp0nge@gmail.com"
  gem.authors = ["Paolo Perego"]
  gem.executables = ['ciphersurfer']
  gem.default_executable = 'ciphersurfer'
  gem.require_path = 'lib'
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ciphersurfer #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
