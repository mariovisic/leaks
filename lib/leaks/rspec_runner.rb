require 'rspec'

module Leaks
  class RSpecRunner < RSpec::Core::Runner
    def self.run(args, err=$stderr, out=nil)
      trap_interrupt
      options = RSpec::Core::ConfigurationOptions.new(args)
      options.parse_options

      RSpec::Core::CommandLine.new(options).run(err, out)
    end
  end
end
