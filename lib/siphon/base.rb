#
#
#
module Siphon
  class Base
    attr_accessor :relation, :scopes, :scope_datatypes


    # Siphon.new(Book.scoped)
    def initialize(relation)
      @relation = relation
    end

    def filter(params)
      @scopes = map_scope_datatypes( params, scope_datatypes )

      scopes.each do |key, value|
        self.relation= relation.send(key, *value)
      end

      relation
    end

    # Possible Datatype
    # -----------------
    # admin: nil
    # category_name: String
    # published: Boolean,
    # age_gt:    Integer
    # before:    Date
    #
    def has_scopes(scope_datatypes = {})
      @scope_datatypes = scope_datatypes.symbolize_keys
      self
    end

  private
    # TODO : for now we're assuming scope_datatypes is a Hash, K ?
    def map_scope_datatypes( params, scope_datatypes )
      scope_hash = {}

      params.symbolize_keys.each do |scope, value|
        next unless scope_datatypes.has_key?(scope)
        scope_hash[scope] = convert_type( value, scope_datatypes[scope] )
      end

      return scope_hash
    end

    def convert_type(value, type)
      v = case type
          when :integer
            Integer(value)
          when :boolean
            value != "false"
          else
            value
          end
    end

  end
end