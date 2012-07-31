module Virgola
  module Relation
    module HasOne
      extend ActiveSupport::Concern

      module ClassMethods
        def has_one(name, options={})
          self.attributes[name.to_s] ||= Virgola::Relation::HasOne::Proxy.new(name.to_sym, options)
        end
      end

      class Proxy
        def initialize(name, options)

        end
      end
    end
  end
end