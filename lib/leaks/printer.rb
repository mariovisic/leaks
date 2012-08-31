module Leaks
  module Printer
    def self.run
      loop { print_status; sleep 0.1 }
    end

    def self.print_status
      print "#{13.chr}#{Spinner} "

      if Runner.ram_usage.increased?
        print "\033[31m#{Runner.ram_usage} Runs: #{Runner.runs} \033[0m"
      else
        print "\033[32m#{Runner.ram_usage} Runs: #{Runner.runs} \033[0m"
      end
    end
  end
end
