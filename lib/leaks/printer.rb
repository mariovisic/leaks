module Leaks
  module Printer
    def self.run
      loop { print_status; sleep 0.1 }
    end

    def self.print_status
      print "#{13.chr}#{Spinner} "

      status = "Runs: #{Runner.runs} #{Runner.ram_usage} Stable: #{Runner.ram_usage.stable_for} sec    "

      if Runner.ram_usage.increased?
        print "\033[31m#{status}\033[0m"
      else
        print "\033[32m#{status}\033[0m"
      end
    end
  end
end
