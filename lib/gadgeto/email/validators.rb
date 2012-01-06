module Gadgeto
  class Email
    module Validators
      def email?(email)
        !!(email =~ /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$/i)
      end
    end
  end
end
