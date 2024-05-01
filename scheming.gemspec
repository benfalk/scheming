# frozen_string_literal: true

require_relative 'lib/scheming/version'

Gem::Specification.new do |spec|
  spec.name = 'scheming'
  spec.version = Scheming::VERSION
  spec.authors = ['Ben Falk']
  spec.email = ['benjamin.falk@yahoo.com']

  spec.summary = 'Designing Data'
  spec.description = 'Ergonomic Data Design for the Masses'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2'

  spec.metadata['source_code_uri'] =
    'https://github.com/benfalk/scheming'

  spec.metadata['changelog_uri'] =
    'https://raw.githubusercontent.com/benfalk/scheming/main/CHANGELOG.md'

  spec.homepage =
    'https://github.com/benfalk/scheming'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) ||
        f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.metadata['rubygems_mfa_required'] = 'true'
end
