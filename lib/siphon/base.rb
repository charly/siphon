#
#
#
module Siphon
  class Base
    attr_accessor :relation

    # Siphon.new(Book.scoped)
    def initialize(relation)
      @proxy = Proxy.new(relation)
      @relation = @proxy.relation
    end

    def with(params)
      @proxy.params = params
      @proxy
    end

  end # Base
end