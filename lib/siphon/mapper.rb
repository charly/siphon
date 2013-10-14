module Siphon
  # ==========
  #   Mapper
  # ==========
  # maps the arguments scope receives to it's type
  # since params are always string we need to specify
  # if they're integers, dates, array, or string (by default)
  #
  class Mapper

    attr_reader :types, :params


    def initialize(types, params)
      @types = types
      @params = params
    end

    # TODO : for now we're assuming scope_datatypes is a Hash, K ?
    def call
      scope_hash = {}

      params.symbolize_keys.each do |scope, value|
        next unless types.has_key?(scope)
        scope_hash[scope] = convert_type(value, types[scope])
      end

      return scope_hash
    end

  private

    def convert_type(value, type)
      v = case type
          when :integer
            Integer(value)
          when :boolean
            value != "false"
          when :string
            value
          when :none
            nil
          else
            value == "nil" ? nil : value
          end
    end




  end
end