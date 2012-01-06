require File.join(File.dirname(__FILE__), '/email/validators')

module Gadgeto
  class Email
    include Email::Validators

    class << self
      def valid?(object)
        o = new object
        o.valid?
      end
    end

    def initialize(email)
      @email = email
    end

    def valid?
      email? @email
    end
  end
end
