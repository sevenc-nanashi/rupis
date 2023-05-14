# frozen_string_literal: true

require_relative "lib/rupis/version"

Gem::Specification.new do |spec|
  spec.name = "rupis"
  spec.version = Rupis::VERSION
  spec.authors = ["sevenc-nanashi"]
  spec.email = ["sevenc7c@sevenc7c.com"]

  spec.summary = "Rust powered Ruby Language Server"
  spec.homepage = "https://github.com/sevenc-nanashi/rupis"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"
  spec.required_rubygems_version = ">= 3.3.11"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/rupis/Cargo.toml"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "syntax_tree", "~> 6.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
