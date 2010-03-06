# Copyright (c) 2007-2008 Operis Systems, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

##
# First, the gemspec
#
require 'rubygems'

spec = Gem::Specification.new do |s|
  # Informational Stuff
  s.name                    = 'pog'
  s.version                 = '1.1'
  s.summary                 = 'POG - Password Operations Gem'
  s.description             = <<END_OF_DESC
A Ruby gem for simplifying random password generation, password strength 
testing, password hashing and salting, and password-hash authentication.
END_OF_DESC
  s.author                  = 'Operis Systems, LLC'
  s.email                   = 'support@operissystems.com'
  s.homepage                = 'http://pog.rubyforge.org'
  s.rubyforge_project       = 'pog'
  
  # Requirements
  s.required_ruby_version   = '>= 1.8.6'
  s.platform                = Gem::Platform::RUBY
  s.require_paths           = [ 'lib' ]
  
  # Testing
  s.test_files              = [ 'test/tc_salt.rb', 
                                'test/tc_password_tests.rb', 
                                'test/tc_password.rb',
                                'test/tc_random_string_generator.rb']
  
  # Documentation
  s.has_rdoc                = true
  s.extra_rdoc_files        = [ 'README', 'LICENSE', 'CHANGELOG', 'NOTICE', 'SECURITY' ]
  
  # Files
  s.files                   = [ 'lib/random_string_generator.rb',
                                'lib/character_ranges.rb', 
                                'lib/password_tests.rb', 
                                'lib/password.rb', 
                                'lib/salt.rb',
                                'lib/pog.rb',
                                'lib/string.rb',
                                'lib/encoding_translation.rb',
                                'Rakefile' ].push(s.test_files).push(s.extra_rdoc_files).flatten
end

##
# Now the Rakefile
# 
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rcov/rcovtask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Run unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.test_files = spec.test_files
  t.verbose = true
end

namespace :test do
  namespace :coverage do
    desc "Delete aggregate coverage data."
    task(:clean) { rm_f "test/coverage.data" }
    task(:clobber) {rm_r 'test/coverage'}
  end
  
  desc 'Aggregate code coverage for unit, functional and integration tests'
  task :coverage do
    puts `rcov test/*.rb --output test/coverage --exclude rcov.rb,activerecord,activesupport,tzinfo`
    # Rcov::RcovTask.new() do |t|
    #   t.libs << "test"
    #   t.test_files = FileList["test/*.rb"]
    #   t.output_dir = "test/coverage"
    #   t.verbose = true
    #   t.rcov_opts << '--aggregate coverage.data'
    # end
  end
end

#desc 'Run tests on rand().'
#Rake::TestTask.new(:test_rand) do |t|
#  t.test_files = 'test/rand_test.rb'
#  t.verbose = true
#end

desc 'Generate documentation.'
task :doc => :rdoc
task :redoc => :rerdoc
desc 'Generate documentation.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = spec.summary
  rdoc.options << '--line-numbers' << '--inline-source'
  spec.extra_rdoc_files.each { |f| rdoc.rdoc_files.include( f ) }
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
