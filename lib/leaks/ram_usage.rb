module Leaks
  class RAMUsage
    def initialize
      @previous  = kilobytes_used
      @current   = @previous
      @stable    = Time.now
      @increased = false
    end

    def update
      @increased = false
      @previous  = @current
      @current   = kilobytes_used

      if @current > @previous
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
