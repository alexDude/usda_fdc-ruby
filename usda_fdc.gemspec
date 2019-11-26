
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "usda_fdc/version"

Gem::Specification.new do |spec|
  spec.name          = "usda_fdc"
  spec.version       = UsdaFdc::VERSION
  spec.authors       = ["Alex Ritchie"]
  spec.email         = ["dudewaitwut@gmail.com"]
  spec.homepage      = 'https://github.com/alexDude/usda_fdc-ruby'
  spec.summary       = "Wrapper for the USDA FoodDate Central"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "oj", '~> 3.9', '>= 3.9.2'
  spec.add_runtime_dependency "faraday", '~> 0.17.0'
  spec.add_runtime_dependency "json", '~> 2.2'
end
