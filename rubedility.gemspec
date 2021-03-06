Gem::Specification.new do |s|
  s.name            = 'rubedility'
  s.version         = '0.0.2'
  s.date            = '2016-03-01'
  s.summary         = 'Codility lessons/tests CLI'
  s.description     = 'Command line access to Codility.com programming lessons and tests'
  s.authors         = ["Brian Holland"]
  s.email           = 'beehollander@gmail.com'
  s.files           = ['lib/rubedility.rb', 'lib/rubedility/lesson.rb', 'lib/rubedility/task.rb', 'lib/rubedility/scraper.rb', 'lib/rubedility/difficulty.rb']
  s.add_runtime_dependency 'launchy'
  s.executables    << 'rubedility'
  s.homepage        = 'http://rubygems.org/gems/rubedility'
  s.license         = 'MIT'
end




























