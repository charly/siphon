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

    def recall
      @recaller = Recaller.new(relation)
    end

  end # Base
end