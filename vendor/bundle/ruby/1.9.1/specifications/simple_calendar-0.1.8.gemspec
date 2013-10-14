# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "simple_calendar"
  s.version = "0.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Oliver"]
  s.date = "2013-05-11"
  s.description = "A simple Rails 3 calendar"
  s.email = ["excid3@gmail.com"]
  s.homepage = "https://github.com/excid3/simple_calendar"
  s.require_paths = ["lib"]
  s.rubyforge_project = "simple_calendar"
  s.rubygems_version = "1.8.25"
  s.summary = "A simple Rails 3 calendar"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0"])
  end
end
