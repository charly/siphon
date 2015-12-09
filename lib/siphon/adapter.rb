module Siphon
  # ==========
  #   Adapter
  # ==========
  #
  # use : determine which scope will not be called &
  #       set args to nil for 'argless' scopes
  #
  #
  class Adapter

    def initialize(formobj)
      @formobj = formobj

      @scopes_hash = assign_scope_hashes @formobj
      @argless     = argless_list @formobj
    end

    def call
      filterout_empty_string_and_nil
      apply_nil_on_argless_scopes
    end

  private
    # Do NOT APPLY SCOPE && reject them from scopes_hash
    # 1. if scope is present in form but with no value (aka: an empty string)
    # 2. if present in formobj but not in form  (aka : a nil value)
    def filterout_empty_string_and_nil
      @scopes_hash.delete_if { |scope, arg| ["", nil].include? @formobj[scope] }
    end

    # scope with no args are listed in @argless
    # we loop & set their arg to nil (aka: no arg with splat)
    # must be called AFTER filterout_empty_string_and_nil
    def apply_nil_on_argless_scopes
      @argless.each {|scope, v| @scopes_hash[scope]= nil if @scopes_hash[scope] }
      @scopes_hash
    end

    # list of virtus attributes with Siphon::Nil type
    def argless_list(formobj)
      formobj.class.
        attribute_set.
        select {|a| a.class == Siphon::Nil}.
        map(&:name)
    end

    # if the form object has #siphon_attributes favor that one
    # usefull to seperate ransack attributes from siphon ones
    def assign_scope_hashes(formobj)
      formobj.respond_to?(:siphon_attributes) ?
        formobj.siphon_attributes : formobj.attributes
    end
  end
end