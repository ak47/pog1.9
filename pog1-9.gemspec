require 'rubygems'

version = File.read('VERSION').strip
raise "no version" if version.empty?

spec = Gem::Specification.new do |s|
  s.name = 'pog19'
  s.version = version 
  s.author = 'Operis Systems, LLC'
  s.email = ''
  s.homepage = 'http://pog.rubyforge.org/'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A Ruby gem for simplifying random password generation'
  s.description = s.summary + ', password strength testing, password hashing and salting, and password-hash authentication.'
  s.files = Dir['**/*'].delete_if { |f| f =~ /(cvs|gem|svn)$/i }
  s.require_path = 'lib'
  s.rdoc_options << '--all' << '--inline-source' << '--main' << 'lib/pog.rb'
  s.has_rdoc = true
  s.rubyforge_project = 'pog'
end