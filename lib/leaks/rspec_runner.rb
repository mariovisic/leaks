require 'rspec'

module Leaks
  class RSpecRunner < RSpec::Core::Runner
    def self.run(args, err, out)
      trap_interrupt
      options = RSpec::Core::ConfigurationOptions.new(args)
      options.parse_options

      unless RSpec::Core::CommandLine.new(options).run(err, out) == 0
        raise RSpecError.new("A test has failed, quitting now. Run again in verbose mode to diagnose the problem")
      end
    end
  end
end
