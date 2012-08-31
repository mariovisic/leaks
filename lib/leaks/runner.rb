module Leaks
  class RSpecError < StandardError; end

  module Runner
    class << self
      attr_reader :ram_usage
      attr_reader :runs
    end

    def self.run(path, verbose=false)
      @ram_usage = RAMUsage.new
      @paths     = Array(path || 'spec')
      @out       = verbose ? $stdout : nil
      @err       = $stderr
      @runs      = 0

      ActiveRecord::Base.logger = nil
      Thread.new { Printer.run }

      RSpecRunner.run(@paths, @err, @out)

      loop do
        RSpecRunner.run([], @err, @out)
        @runs +=1
      end
    end
  end
end
