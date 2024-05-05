# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

desc 'Run the type checker'
task :typecheck do
  sh 'bundle exec solargraph typecheck --level typed'
end

task default: %i[spec rubocop typecheck]
