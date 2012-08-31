module Leaks
  module Spinner
    @chars = [ '|', '/', '-', '\\' ]

    def self.to_s
      @chars.push @chars.shift
      @chars[0]
    end
  end
end
