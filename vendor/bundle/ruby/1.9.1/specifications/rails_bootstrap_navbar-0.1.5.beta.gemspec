# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails_bootstrap_navbar"
  s.version = "0.1.5.beta"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jules Copeland"]
  s.date = "2012-03-24"
  s.description = "A helper method for easy generation of Twitter Bootstrap Navigation menus in Rails"
  s.email = ["jules@julescopeland.com"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Generate Bootstrap Navbars in Rails views"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 3.0.0"])
  end
end
