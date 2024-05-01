# frozen_string_literal: true

Dir.glob(File.join(__dir__, 'custom_matchers', '*.rb'), &method(:require))
