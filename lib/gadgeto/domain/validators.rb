
module Gadgeto
  class Domain
    module Validators
      class << self

        def third_level_domain?(domain_name)
          !!( domain_name =~ domain_regex(3)  )
        end

        private

        ##
        # Validates domain names against usual pattern defined in RFC 1035.
        #
        # * http://tools.ietf.org/html/rfc1035
        #
        def domain_regex(level)
          label = '(([a-z]|\d)+([a-z]|\d|-)*([a-z]|\d)+|([a-z]|\d))'
          %r{\A#{label}(\.#{label}){#{level - 1}}\Z}i
        end
      end
    end
  end
end
