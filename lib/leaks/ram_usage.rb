module Leaks
  class RAMUsage
    def initialize
      @previous = kilobytes_used
      @current  = @previous
    end

    def increased?
      current > @previous
    end

    def current
      @previous = @current
      @current  = kilobytes_used
    end

    def to_s
      "Usage: #{current}KB"
    end

    private

    def kilobytes_used
      `ps -o vsz= -p #{$$}`.to_i
    end
  end
end
