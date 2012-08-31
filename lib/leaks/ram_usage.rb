module Leaks
  class RAMUsage
    def initialize
      @previous = kilobytes_used
      @current  = @previous
      @stable   = Time.now
    end

    def increased?
      if current > @previous
        @stable = Time.now
        true
      else
        false
      end
    end

    def current
      @previous = @current
      @current  = kilobytes_used
    end

    def to_s
      "Usage: #{current}KB"
    end

    def stable_for
      (Time.now - @stable).to_i
    end

    private

    def kilobytes_used
      `ps -o vsz= -p #{$$}`.to_i
    end
  end
end
