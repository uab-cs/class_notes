require 'date'
require_relative 'lib/class_notes'

Gem::Specification.new do |s|
  s.name        = 'class_notes'
  s.version     = Version.join(".")
  s.date        = Date.today.strftime('%Y-%m-%d')
  s.summary     = "make your classes take notes"
  s.description = "wrap a classes instance methods in logic that keeps track of their actions"
  s.authors     = ["annacrombie"]
  s.email       = 'stone.tickle@gmail.com'

  s.files       = Dir.glob("./lib/**/*.rb") +
                  Dir.glob("./test/**/*.rb") +
                  ["./README.md"]

  s.homepage    = 'https://github.com/uab-cs/class_notes/'
  s.license     = 'MIT'
end
