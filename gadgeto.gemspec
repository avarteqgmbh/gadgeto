# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gadgeto"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robert Gogolok", "Matthias Zirnstein"]
  s.date = "2012-01-06"
  s.description = "collection of useful code snippets"
  s.email = "rgogolok@avarteq.de"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".travis.yml",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "gadgeto.gemspec",
    "lib/gadgeto.rb",
    "lib/gadgeto/dslable.rb",
    "lib/gadgeto/email.rb",
    "lib/gadgeto/email/validators.rb",
    "lib/gadgeto/sanitize_filename.rb",
    "lib/gadgeto/time_of_day.rb",
    "spec/lib/gadgeto/dslable_spec.rb",
    "spec/lib/gadgeto/email_spec.rb",
    "spec/lib/gadgeto/sanitize_filename_spec.rb",
    "spec/lib/gadgeto/time_of_day_spec.rb",
    "spec/spec_helper.rb",
    "test/helper.rb",
    "test/test_gadgeto.rb"
  ]
  s.homepage = "http://github.com/avarteqgmbh/gadgeto"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "collection of useful code snippets"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
