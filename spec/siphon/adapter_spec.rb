require "spec_helper"


describe Siphon::Adapter, focus: true do

  describe "scope ->() {...}" do
    context "when Formobject#attributes is coerced to Siphon::Nil" do
      it "will not return the scope if the argument is false" do
        formobj     = Formobj.new(stale: "0")

        scopes_hash = Siphon::Adapter.new(formobj).call
        expect(scopes_hash).to eq({})
      end

      it "will return the scope with nil if the argument's true" do
        formobj     = Formobj.new(stale: "1")

        scopes_hash = Siphon::Adapter.new(formobj).call
        expect(scopes_hash).to eq({stale: nil})
      end
    end
  end

  describe "scope ->(args) {...}" do
    context "when Formobject takes string values" do
      it "will return Formobject typecasted values"  do
        formobj = Formobj.new(after: "1950")

        scopes_hash = Siphon::Adapter.new(formobj).call
        expect(scopes_hash).to eq(after: 1950)
      end
    end

    context "when Formobject#attributes returns empty strings" do
      it "return hash withtout empty strings"  do
        formobj     = Formobj.new(admin: "")

        scopes_hash = Siphon::Adapter.new(formobj).call
        expect(scopes_hash.keys).to_not include(:admin)
      end
    end
  end
end