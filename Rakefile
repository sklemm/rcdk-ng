# =============================================
# RCDK - The Chemistry Development Kit for Ruby
# =============================================
#
# Project Info: http://rubyforge.org/projects/rcdk
# Blog: http://depth-first.com
#
# Copyright (C) 2006 Richard L. Apodaca
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License version 2.1 as published by the Free Software
# Foundation.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free
# Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor
# Boston, MA 02111-1301, USA.

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

PKG_VERSION = "0.3.0"

PKG_FILES = FileList[
  "Rakefile", "README",
  "lib/**/*.rb",
  "test/**/*",
  "java/lib/*.jar"
]

desc "Default task"
task :default => [:test]


task :dist => [:rdoc]

desc "Clean up"
task :clean do
  rm_rf "dist"
  rm_rf "doc"
  rm_rf "pkg"
  rm_rf "output"
end

desc "Create the source distribution"
task :dist do
  rm_rf "dist"
  
  mkdir "dist"
  mkdir "dist/doc"
  mkdir "dist/lib"
  mkdir "dist/lib/rcdk"
  mkdir "dist/java"
  mkdir "dist/java/lib"
  mkdir "dist/java/src"
  mkdir "dist/test"
  
  mv Dir.glob('doc/*'), 'dist/doc'
  cp_r Dir.glob('*.rb'), 'dist'
  cp_r Dir.glob('lib/*.rb'), 'dist/lib'
  cp_r Dir.glob('lib/rcdk/*.rb'), 'dist/lib/rcdk'
  cp_r Dir.glob('java/lib/*.jar'), 'dist/java/lib'
  cp_r Dir.glob('test/*.rb'), 'dist/test'
  cp 'Rakefile', 'dist'
  cp 'README', 'dist'
  cp 'LICENSE', 'dist'
end

Rake::TestTask.new do |t|

  rm_rf "output"
  mkdir "output"
  
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = "Ruby CDK"
  rdoc.rdoc_files.include('README')
  rdoc.options << '--line-numbers'
  rdoc.options << '--inline-source'
  rdoc.options << '--main' << 'README'
  rdoc.rdoc_files.include('lib/**/*.rb')
end

spec = Gem::Specification.new do |s|
  s.name = 'rcdk'
  s.version = PKG_VERSION
  s.author = "Richard Apodaca"
  s.homepage = "http://rubyforge.org/projects/rcdk"
  s.platform = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.autorequire = 'rcdk'
  s.has_rdoc = true
  s.files = PKG_FILES
  s.summary = "A Ruby wrapper for the Chemistry Development Kit"
  s.add_dependency("rjb", ">= 1.0.0")
  s.description = s.summary
  s.extra_rdoc_files = ['README']
  s.rdoc_options << '--title' << 'Ruby Chemistry Development Kit (RCDK)' <<
                       '--main' << 'README' <<
                       '--line-numbers'
end

Rake::GemPackageTask.new(spec) do |gem|
  gem.need_tar = true
  gem.need_tar_gz = true
  gem.package_files += PKG_FILES
end