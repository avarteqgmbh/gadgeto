
require File.join(File.dirname(__FILE__), '/domain/validators')

module Gadgeto
  class Domain
    include Domain::Validators

    class << self
      def valid?(object)
        o = new object
        o.valid?
      end
    end

    def initialize(domain)
      @domain = domain
    end

    def valid?
      domain? @domain
    end

    def third_level_domain?
      super(@domain)
    end

  end
end
