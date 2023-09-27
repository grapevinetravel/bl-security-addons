# frozen_string_literal: true

require_relative 'lib/bl-security-addons/version'

Gem::Specification.new do |spec|
  spec.name = 'bl-security-addons'
  spec.version = BlSecurityAddons::VERSION
  spec.authors = ['AlejandroFernandesAntunes']
  spec.email = ['aantunes70@hotmail.com']

  spec.summary = 'Basic security routines to include in satellites.'
  spec.description = 'Toolset to include in satellites to provide basic security routines.'
  spec.homepage = 'https://github.com/grapevinetravel/bl-security-addons'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/grapevinetravel/bl-security-addons'
  spec.metadata['changelog_uri'] = 'https://github.com/grapevinetravel/bl-security-addons'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
