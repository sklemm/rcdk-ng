spec = Gem::Specification.new do |s|
  s.name = 'rcdk-ng'
  s.version = '0.5.0'
  s.author = "Sebastian Klemm"
  s.homepage = ""
  s.platform = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.has_rdoc = true
  s.files = ["README", "LICENSE", "Rakefile"] + Dir['java/lib/*.jar'] + Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.summary = "A Ruby wrapper for the Chemistry Development Kit"
  s.add_dependency("rjb", ">= 1.0.0")
  s.description = s.summary
  s.extra_rdoc_files = ['README']
  s.rdoc_options << '--title' << 'Ruby Chemistry Development Kit (RCDK)' <<
                       '--main' << 'README' <<
                       '--line-numbers'
end
