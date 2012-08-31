module Leaks
  class RSpecError < StandardError; end

  module Runner
    class << self
      attr_reader :ram_usage
      attr_reader :runs
    end

    def self.run(path = 'spec', verbose=false)
      @ram_usage = RAMUsage.new
      @paths     = Array(path)
      @out       = verbose ? $stdout : nil
      @err       = $stderr
      @runs      = 0
      @printer   = Thread.new { Printer.run }

      ActiveRecord::Base.logger = nil
      RSpecRunner.run(@paths, @err, @out)

      loop do
        RSpecRunner.run([], @err, @out)
        @runs +=1
      end
    end
  end
end
