module Siphon
  # ========
  #   Base
  # ========
  class Base
    attr_accessor :relation

    # Siphon.new(Book.scoped)
    def initialize(relation)
      @relation = relation
    end

    def scope(formobject)
      scopeobject = Siphon::Adapter.new(formobject).call

      scopeobject.each do |meth, arg|
        self.relation = relation.public_send(meth, arg)
      end

      relation
    end

  end # Base
end