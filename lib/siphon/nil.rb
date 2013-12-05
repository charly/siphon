require "virtus"

module Siphon
  class Nil < ::Virtus::Attribute

    # if the value is false
    def coerce(value)
      [nil, "", "0", "false", "f", "F"].include?(value) ? nil : 1
    end

  end
end