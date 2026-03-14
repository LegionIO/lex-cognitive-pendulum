# frozen_string_literal: true

require 'legion/extensions/cognitive_pendulum/helpers/constants'
require 'legion/extensions/cognitive_pendulum/helpers/pendulum'
require 'legion/extensions/cognitive_pendulum/helpers/pendulum_engine'
require 'legion/extensions/cognitive_pendulum/runners/cognitive_pendulum'

module Legion
  module Extensions
    module CognitivePendulum
      class Client
        include Runners::CognitivePendulum

        def initialize(**)
          @pendulum_engine = Helpers::PendulumEngine.new
        end

        private

        attr_reader :pendulum_engine
      end
    end
  end
end
