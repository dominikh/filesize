# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{filesize}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dominik Honnef"]
  s.cert_chain = ["/home/dominikh/.rubyforge/gem-public_cert.pem"]
  s.date = %q{2009-07-26}
  s.description = %q{filesize is a small class for handling filesizes with both the SI and binary prefixes, allowing conversion from any size to any other size.}
  s.email = %q{dominikho@gmx.net}
  s.extra_rdoc_files = ["README.markdown", "CHANGELOG", "lib/filesize.rb"]
  s.files = ["Rakefile", "README.markdown", "CHANGELOG", "lib/filesize.rb", "Manifest", "filesize.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://filesize.rubyforge.org/}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Filesize", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = %q{filesize}
  s.rubygems_version = %q{1.3.1}
  s.signing_key = %q{/home/dominikh/.rubyforge/gem-private_key.pem}
  s.summary = %q{filesize is a small class for handling filesizes with both the SI and binary prefixes, allowing conversion from any size to any other size.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
