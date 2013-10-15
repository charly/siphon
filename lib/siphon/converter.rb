module Siphon
  # =============
  #   Converter
  # =============
  # converts the damn argument in it's given type
  #
  class Converter

    attr_reader :type, :value


    def initialize(type, value)
      @type = types
      @value = value
    end


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