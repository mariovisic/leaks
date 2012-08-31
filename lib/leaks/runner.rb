module Leaks
  class RSpecError < StandardError; end

  class Runner
    def self.run(path, verbose=false)
      @ram_usage = RAMUsage.new
      @paths     = Array(path || 'spec')
      @out       = verbose ? $stdout : nil
      @err       = $stderr
      @runs      = 0
      @chars     = [ '|', '/', '-', '\\' ]

      ActiveRecord::Base.logger = nil
      RSpecRunner.run(@paths, @err, @out)

      Thread.new do
        loop do
          sleep 0.1
          print_status
        end
      end

      loop do
        RSpecRunner.run([], @err, @out)

        @runs +=1
      end
    end

    def self.print_status
      print "#{13.chr}#{@chars[0]} "
      @chars.push @chars.shift

      if @ram_usage.increased?
        print "\033[31m#{@ram_usage} Runs: #{@runs.to_s} \033[0m"
      else
        print "\033[32m#{@ram_usage} Runs: #{@runs.to_s} \033[0m"
      end
    end
  end
end
