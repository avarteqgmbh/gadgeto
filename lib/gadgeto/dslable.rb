
module Gadgeto
  #
  #    class Foo
  #      include Dslable
  #      include Dslable::Display
  #
  #      dslable_method :item, :key, '*arguments'
  #
  #
  #      def inspect
  #        attributes[:key]
  #      end
  #    end
  #
  #    f = Foo.new
  #
  #
  #    f.draw do
  #      item 'Startseite', :baem => :bum do
  #        item 'terms'
  #        item 'imprint'
  #      end
  #
  #      item 'Praemien' do
  #        item 'Kueche' do
  #          item 'Toepfe'
  #        end
  #      end
  #    end
  #
  #    f.display :items
  module Dslable

    def self.included(base)
      base.extend ClassMethods
    end

    def self.extended(base)
      class << base
        self.extend ClassMethods
      end
    end

    module Display
      module InstanceMethods
        self.instance_eval do
          self.class_eval <<-RUBY

            def display(storage, level = 0, &block)
              send(storage).each do |i|
                if block
                  block.call i, level
                else
                  puts '%s%s' % ['  ' * level, i.inspect]
                end

                i.display storage, level + 1, &block if i.items.size > 0
              end

              return nil
            end
          RUBY
        end
      end

      include InstanceMethods
    end

    module ClassMethods
      def dslable_method(method, *args)
        self.instance_eval do

          stored_at = method.to_s + 's' # pluralize with ActiveSupport

          # method_params:          key, *arguments, options = {}
          # method_values_set:      i.name = name
          # method_setters_getters: def key, def arguments, def options

          method_params, method_values_set, method_accessors = [], [], []

          args.each do |arg|
            unless [String, Symbol, Hash].include? arg.class
              raise ArgumentError, 'allowed arguments are Symbols, Strings and Hashes'
            end

            method_params          << (arg.is_a?(Hash) ? arg.to_a : [arg]).flatten.join(' = ')

            arg_name = (arg.is_a?(Hash) ? arg.keys.first : arg).to_s.gsub('*', '')

            method_values_set      << arg_name
            method_accessors       << arg_name
          end

          method_params = method_params.join(', ')

          method_values_set = method_values_set.map do |p|
            'i.%s = %s' % [p, p]
          end.join(';')

          method_accessors = method_accessors.map do |p|
            "def #{p}; read_attribute(:#{p}); end;" + "def #{p}=(v); write_attribute(:#{p}, v); end;"
          end.join

          self.class_eval <<-RUBY

            #{method_accessors}

            def draw(code = nil, &block)
              i = self.class.new

              if code
                i.instance_eval code
              else
                i.instance_eval &block
              end

              @#{stored_at} = i.#{stored_at}
              return nil
            end

            def #{method.to_s}(#{method_params}, &block)
              i = self.class.new
              #{method_values_set}

              i.instance_eval &block if block

              self.#{stored_at} << i
            end

            def #{stored_at}
              @#{stored_at} ||= []
            end

            def #{stored_at}=(v)
              @#{stored_at} = v
            end

            def attributes
              @attributes ||= {}
            end

            def attributes=(a)
              @attributes = a
            end

            def read_attribute(n)
              attributes[n]
            end

            def write_attribute(n, v)
              attributes[n] = v
            end

          RUBY

        end
      end
    end
  end
end
