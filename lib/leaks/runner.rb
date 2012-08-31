module Leaks
  class Runner
    def initialize(path = 'spec')
      @path      = path
      @ram_usage = RAMUsage.new
      @runs      = 0
    end

    def run
      ActiveRecord::Base.logger = nil
      RSpecRunner.run([@path])

      loop do
        print_status
        RSpecRunner.run([])
        @runs +=1
      end
    end

    private

    def print_status
      print 13.chr

      if @ram_usage.increased?
        print "\033[31mRuns: #{@runs.to_s} #{@ram_usage}\033[0m"
      else
        print "\033[32mRuns: #{@runs.to_s} #{@ram_usage}\033[0m"
      end
    end
  end
end
