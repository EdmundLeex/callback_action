# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'action_callback/version'

Gem::Specification.new do |spec|
  spec.name        = "action_callback"
  spec.version     = ActionCallback::VERSION
  spec.summary     = 'Add callbacks to your ActiveRecord models or plain Ruby classes'
  spec.description = "Here you can add callbacks to your models using `before_action`, `after_action`"

  spec.required_ruby_version = ">= 2.1.0"

  spec.license = "MIT"

  spec.authors  = ["Edmund Li"]
  spec.email    = ["edmund.xz.lee@gmail.com"]
  spec.homepage = "https://github.com/EdmundLeex/action_callback"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 4.2"
end
