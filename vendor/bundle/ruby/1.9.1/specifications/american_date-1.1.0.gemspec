# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "american_date"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeremy Evans"]
  s.date = "2013-03-22"
  s.description = "American style month/day/year date parsing for ruby 1.9"
  s.email = "code@jeremyevans.net"
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "MIT-LICENSE"]
  s.files = ["README.rdoc", "CHANGELOG", "MIT-LICENSE"]
  s.homepage = "https://github.com/jeremyevans/ruby-american_date"
  s.rdoc_options = ["--quiet", "--inline-source", "--line-numbers", "--title", "american_date: American style month/day/year date parsing for ruby 1.9", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "American style month/day/year date parsing for ruby 1.9"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
