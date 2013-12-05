module Siphon
  # ========
  #   Base
  # ========
  #
  # use : Handles the ActiveRelation on which
  #       scopes from a **FormObject** will be applied
  #
  # e.g : Siphon::Base.new(Book.published).scope(BookForm.new(params[:q]))
  #
  class Base
    attr_accessor :relation

    # Siphon.new(Book.scoped)
    def initialize(relation)
      @relation = relation
    end

    def scope(formobject)
      scopes_hash = Siphon::Adapter.new(formobject).call

      scopes_hash.each do |meth, arg|
        self.relation = relation.send(meth, *arg)
      end

      relation
    end

  end # Base
end