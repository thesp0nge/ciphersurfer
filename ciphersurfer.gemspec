# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ciphersurfer/version'

Gem::Specification.new do |spec|
  spec.name          = "ciphersurfer"
  spec.version       = Ciphersurfer::VERSION
  spec.authors       = ["Paolo Perego"]
  spec.email         = ["thesp0nge@gmail.com"]
  spec.summary       = %q{ciphersurfer is a tool to check how strong is an SSL certificate. It also check for POODLE vulnerability, if your server supports SSLv3}
  spec.description   = %q{ciphersurfer is a tool to check how strong is an SSL certificate. It also check for POODLE vulnerability, if your server supports SSLv3}
  spec.homepage      = "https://codiceinsicuro.it"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rainbow"
  spec.add_dependency "httpclient"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
