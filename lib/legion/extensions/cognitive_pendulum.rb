# frozen_string_literal: true

require 'securerandom'
require_relative 'cognitive_pendulum/version'
require_relative 'cognitive_pendulum/helpers/constants'
require_relative 'cognitive_pendulum/helpers/pendulum'
require_relative 'cognitive_pendulum/helpers/pendulum_engine'
require_relative 'cognitive_pendulum/runners/cognitive_pendulum'
require_relative 'cognitive_pendulum/client'

module Legion
  module Extensions
    module CognitivePendulum
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
