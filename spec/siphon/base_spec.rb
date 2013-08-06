require "spec_helper"

class Tree
end

describe Siphon::Base do

  describe "#initialize" do

    it "must initialize with an ActiveRelation" do
      expect { Siphon::Base.new }.to raise_error(ArgumentError)
    end

    it "sets @relation" do
      relation = double
      siphon = Siphon::Base.new(relation)

      expect(siphon.relation).to eq(relation)
    end
  end

  describe "#has_scopes" do

    it "returns self" do
      siphon = Siphon::Base.new("")

      expect(siphon.has_scopes({published: nil})).to  eq(siphon)
    end

    it "sets scope_datatypes" do
      siphon = Siphon::Base.new("").has_scopes(published: :integer)

      expect(siphon.scope_datatypes).to eq(published: :integer)
    end
  end

  describe "#filter" do

    it "triggers a scope with string arg (default)" do
      relation = double
      siphon = Siphon::Base.new(relation).has_scopes(name: nil)

      expect(relation).to receive(:name).with("jack")

      siphon.filter(name: "jack")
    end

    it "triggers a scope with an integer arg" do
      relation = double
      siphon = Siphon::Base.new(relation).has_scopes(age_gt: :integer)

      expect(relation).to receive(:age_gt).with(18)

      siphon.filter(age_gt: "18")
    end

    it "triggers a scope with a boolean arg" do
      relation = double
      siphon = Siphon::Base.new(relation).has_scopes(admin: :boolean)

      expect(relation).to receive(:admin).with(false)

      siphon.filter(admin: "false")
    end

    it "chains multiple scopes" do
      relation = double
      siphon = Siphon::Base.new(relation).has_scopes(age_gt: :integer, admin: :boolean)

      expect(relation).to receive(:admin).with(false).and_return(relation)
      expect(relation).to receive(:age_gt).with(18).and_return(relation)

      siphon.filter(age_gt: "18", admin: "false")
    end

    it "chains **only** scopes defined by has_scopes" do
      relation = double
      siphon = Siphon::Base.new(relation).has_scopes(age_gt: :integer)

      expect(relation).to receive(:age_gt)
      expect(relation).to_not receive(:controller)

      siphon.filter(age_gt: "18", controller: "books_controller")
    end
  end

  # TESTING PRIVATE METHOD !
  describe "PRIVATE !! : #map_scope_datatypes" do

    it "maps datatype date" do
      pending "IGNORE & DELETE if not working"
      siphon = Siphon::Base.new("")
      siphon.map_scope_datatypes({age_gt: "18"}, {age_gt: :integer}).should == {age_gt: 18}
    end
  end

end