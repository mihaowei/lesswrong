Gem::Specification.new do |s|
  s.name        = 'lesswrong'
  s.version     = '0.0.3'
  s.date        = '2016-09-11'
  s.summary     = 'Navigate the LW sequences from the command line'
  s.description = "Allows the user to quickly navigate through the LW sequences from the command line"
  s.authors     = ["Noah Milstein"]
  s.email       = 'noahamilstein@gmail.com'
  s.files       = ["lib/lesswrong.rb"]
  s.executables << 'lesswrong'
  s.homepage    =
    'https://github.com/noahmilstein/lesswrong'
  s.license       = 'MIT'
  s.add_development_dependency "bundler", "~> 1.12"
  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "Nokogiri", "~> 1.6.8"
  s.add_development_dependency "launchy", "~> 2.4.3"
end
