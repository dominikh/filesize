# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = "filesize"
  s.version = "0.1.1"
  s.licenses = ["MIT"]
  s.authors = ["Dominik Honnef"]
  s.description = "filesize is a small class for handling filesizes with both the SI and binary prefixes, allowing conversion from any size to any other size."
  s.summary = s.description

  s.email = "dominikh@fork-bomb.org"
  s.has_rdoc = "yard"
  s.files = Dir.glob("{lib,spec}/**/*.rb") + ["LICENSE", "README.md"]
  s.homepage = "https://github.com/dominikh/filesize"
  s.required_ruby_version = ">= 1.8.6"

  s.add_development_dependency "rspec", "~> 3.0"
end
