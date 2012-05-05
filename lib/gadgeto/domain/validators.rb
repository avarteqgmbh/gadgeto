
module Gadgeto
  class Domain
    module Validators

      def domain?(domain_name)
        !!(domain_name =~ domain_regex(0..10))
      end

      def third_level_domain?(domain_name)
        !!(domain_name =~ domain_regex(3))
      end

      protected

      ##
      # Validates domain names against usual pattern defined in RFC 1035.
      #
      # * http://tools.ietf.org/html/rfc1035
      #
      def domain_regex(level)
        label = '(([a-z]|\d)+([a-z]|\d|-)*([a-z]|\d)+|([a-z]|\d)){1,63}'
        cardinal = if level.kind_of?(Range)
                     "#{level.min},#{level.max}"
                   else
                     level - 1
                   end
        %r{\A#{label}(\.#{label}){#{cardinal}}\Z}i
      end

    end
  end
end
