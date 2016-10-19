# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sensu/plugins/atlassian/version'

Gem::Specification.new do |spec|
  spec.name          = "sensu-plugins-atlassian"
  spec.version       = Sensu::Plugins::Atlassian::VERSION
  spec.authors       = ["Steven Ayers"]
  spec.email         = ["steveay99@gmail.com"]

  spec.summary       = 'Atlassian Suite Status Checker'
  spec.description   = 'Checks the status page of Atlassian apps'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'sensu-plugin', '~> 1.2'
  spec.add_runtime_dependency 'rest-client', '1.8.0'
  spec.add_runtime_dependency 'chronic_duration', '0.10.6'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
end
