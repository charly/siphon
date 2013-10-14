module Siphon
  # =========
  #   Proxy
  # =========
  # handles the method_missing calls
  #
  class Proxy < BasicObject
    attr_accessor :relation, :params
    alias_method :to_r, :relation


    def initialize(relation, siphon)
      @relation = relation
    end

    def scope_in_params?(meth)
      raise "You must define params before calling scopes" unless params
      params.keys.include?( meth )
    end

    def convert(param_value, meth_arg)
      # Converter.new(param_value, meth_arg)
      param_value || meth_arg
    end

    def call_scope(meth, *args)
      converted_args = convert( params[meth], args )
      self.relation= @relation.send(meth, converted_args)

      return self
    end

    def method_missing(meth, *args)
      if scope_in_params?( meth.to_s )
        call_scope(meth, args)
      else
        @relation.respond_to?(meth) ? self : super
      end
    end

  end
end