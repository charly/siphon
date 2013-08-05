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

      expect(siphon.has_scopes(:published)).to  eq(siphon)
    end

    it "registers scope_datatypes" do
      siphon = Siphon::Base.new("").has_scopes(published: :integer)

      expect(siphon.scope_datatypes).to eq(published: :integer)
    end
  end

  describe "#filter" do

    it "`sends` one params keys to an ActiveRelation" do
      relation = double
      expect(relation).to receive(:name).with("jack").and_return(relation)
      siphon = Siphon::Base.new(relation).has_scopes(name:nil)

      expect(siphon.filter(name: "jack")).to eq relation
    end

    it "`sends` one params keys to an ActiveRelation" do
      relation = double
      expect(relation).to receive(:age_gt).with(18).and_return(relation)
      siphon = Siphon::Base.new(relation).has_scopes(age_gt: :integer)

      expect(siphon.filter(age_gt: "18")).to eq relation
    end

    it "`sends` one params keys to an ActiveRelation" do
      relation = double
      expect(relation).to receive(:admin).with(false).and_return(relation)
      siphon = Siphon::Base.new(relation).has_scopes(admin: :boolean)

      expect(siphon.filter(admin: "false")).to eq relation
    end

    it "`sends` multiple keys to an ActiveRelation" do
      relation = double
      expect(relation).to receive(:admin).with(false).and_return(relation)
      expect(relation).to receive(:age_gt).with(18).and_return(relation)
      siphon = Siphon::Base.new(relation).has_scopes(age_gt: :integer, admin: :boolean)

      expect(siphon.filter(age_gt: "18", admin: "false")).to eq relation
    end



  end


  # TESTING PRIVATE METHOD !
  describe "#map_scope_datatypes" do

    it "maps no scope value to nil" do
      siphon = Siphon::Base.new("")
      siphon.map_scope_datatypes({sorted: nil}, {sorted: nil}) == {sorted: nil}
    end

    it "maps default datatype string" do
      siphon = Siphon::Base.new("")
      siphon.map_scope_datatypes({sorted: nil}, {sorted: "name"}) == {sorted: "name"}
    end

    it "maps datatype boolean" do
      siphon = Siphon::Base.new("")
      siphon.map_scope_datatypes({published: :boolean}, {published: "false"}).should == {published: false}
    end

    it "maps datatype integer" do
      siphon = Siphon::Base.new("")
      siphon.map_scope_datatypes({age_gt: :integer}, {age_gt: "18"}).should == {age_gt: 18}
    end

    it "maps datatype date" do
      pending "map datatype date"
      siphon = Siphon::Base.new("")
      siphon.map_scope_datatypes({age_gt: :integer}, {age_gt: "18"}).should == {age_gt: 18}
    end
  end

end