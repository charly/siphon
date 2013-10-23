require "spec_helper"


describe Siphon::Adapter, focus: false do

  context "when Formobject#attrinbutes returns empty strings" do
    it "return hash withtout empty strings"  do
      formobj     = Formobj.new(name: "proust", admin: "", after: "")
      scopes_hash = Siphon::Adapter.new(formobj).call

      expect(scopes_hash.keys).to_not include(:admin)
    end
  end

  # context "Formobject returns nil" do
  #   it "will return nil"  do
  #   end
  # end

  context "when Formobject not present", focus: true do
    it "will return default values"  do
      # formobj     = Formobj.new(name: "proust", admin: "", after: "")
      # scopes_hash = Siphon::Adapter.new(formobj).call

      # expect(scopes_hash.keys).to_not include(:admin)
    end
  end

  context "when Formobject#attributes returns string values" do
    it "will return typecasted values"  do
      formobj     = Formobj.new(name: "proust", admin: "1", after: "1950")
      scopes_hash = Siphon::Adapter.new(formobj).call

      expect(scopes_hash).to eq(name: "proust", admin: true, after: 1950)
    end
  end



end