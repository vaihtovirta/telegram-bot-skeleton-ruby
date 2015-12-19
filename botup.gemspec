# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'botup/version'

Gem::Specification.new do |spec|
  spec.name          = 'botup'
  spec.version       = Botup::VERSION
  spec.authors       = ['Emil Shakirov']
  spec.email         = ['5o.smoker@gmail.com']

  spec.summary       = 'Telegram bot boilerplate generator'
  spec.description   = 'Command-line tool for generating boilerplate for telegram bot.'
  spec.homepage      = 'https://github.com/vaihtovirta/botup'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
end
