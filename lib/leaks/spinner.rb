module Leaks
  module Spinner
    @chars = [ '|', '/', '-', '\\' ]

    def self.spin
      @chars.push @chars.shift
    end

    def self.to_s
      @chars[0]
    end
  end
end
