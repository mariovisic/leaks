module Leaks
  class RSpecError < StandardError; end

  class Runner
    def self.run(path, verbose=false)
      @ram_usage = RAMUsage.new
      @paths     = Array(path || 'spec')
      @out       = verbose ? $stdout : nil
      @err       = $stderr
      @runs      = 0

      ActiveRecord::Base.logger = nil
      RSpecRunner.run(@paths, @err, @out)

      loop do
        print_status
        RSpecRunner.run([], @err, @out)

        @runs +=1
      end
    end

    def self.print_status
      print 13.chr

      if @ram_usage.increased?
        print "\033[31mRuns: #{@runs.to_s} #{@ram_usage}\033[0m"
      else
        print "\033[32mRuns: #{@runs.to_s} #{@ram_usage}\033[0m"
      end
    end
  end
end
