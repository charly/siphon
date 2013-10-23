module Siphon
  # ==========
  #   Adapter
  # ==========
  #
  # use : determine which scope will be called
  #   1. takes a formobject (aka must respond to attributes)
  #   2. filters out empty strings, nils & ???
  # Adapter must respond to call
  # scope :admin, ->(bool) { where(admin: bool) }
  class Adapter
    attr_reader :formobj

    def initialize(formobj)
      @formobj = formobj
      @adapted = []
    end

    def call
      formobj.scopes.each do |meth, arg|
        next unless calling?( meth )
        @adapted << [meth, formobj.public_send(meth)]
      end

      return Hash[@adapted]
    end

  private

    def calling?(meth)
      returned = meth && formobj.public_send(meth)

      # binding.pry

      case returned
      when ""
        false
      when nil
        false
      else
        true
      end
    end
  end
end