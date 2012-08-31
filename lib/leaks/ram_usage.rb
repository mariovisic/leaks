module Leaks
  class RAMUsage
    def initialize
      @current   = kilobytes_used
      @highest   = @current
      @stable    = Time.now
      @increased = false
    end

    def update
      @increased = false
      @current   = kilobytes_used

      if @current > @highest
        @highest   = @current
        @increased = true
        @stable    = Time.now
      end
    end

    def increased?
      @increased
    end

    def current
      @current
    end

    def to_s
      "Current: #{current}KB Highest: #{@highest}KB"
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
