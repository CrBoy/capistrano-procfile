# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "capistrano-procfile"
  spec.version       = "0.1.2"
  spec.authors       = ["CrBoy"]
  spec.email         = ["crboy@crboy.net"]

  spec.summary       = %q{Export Procfile to system init daemon configurations}
  spec.description   = %q{Procfile defines what processes to run for whole application. This gem allows capistrano to export the Procfile to systemd init daemon (e.g. systemd, upstart) configurations. This makes the application integrating with systemd better.}
  spec.homepage      = "http://github.com/CrBoy/capistrano-procfile"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.5"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
