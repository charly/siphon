module Siphon
  # =========
  #   Recaller
  # =========
  # handles the method_missing calls
  #
  class Recaller #< BasicObject
    attr_accessor :relation, :scopes, :params
    alias_method :to_r, :relation


    def initialize(relation)
      @relation = relation
      @scopes = []
    end

    def convert(param_value, meth_arg)
      # Converter.new(param_value, meth_arg)
      param_value || meth_arg
    end

    def register(meth, *args)
      @scopes << [meth, *args]

      return self
    end

    def with(params)
      @params = params
      call_scopes

      return relation
    end

    def call_scopes
      scopes.each do |(meth, args)|
        converted_args = convert(params[meth.to_s], args)

        self.relation= relation.send(meth, converted_args)
      end
    end



    def method_missing(meth, *args)

      # register those methods
      register(meth, args)


    end

  end
end