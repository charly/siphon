require "spec_helper"

class Tree
end

describe Siphon::Base, focus: true do

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

  describe "#with" do

    it "returns proxy" do
      siphon = Siphon::Base.new("")

      expect(siphon.with({published: nil})).to be_kind_of(Siphon::Proxy)
    end

    it "sets params" do
      siphon = Siphon::Base.new("").with(published: :integer)

      expect(siphon.params).to eq(published: :integer)
    end
  end

  describe "#proxy" do
    it "handles the scope calls" do
      relation = double
      siphon = Siphon::Base.new(relation)


      expect(relation).to receive(:admin).with("yes").and_return(relation)
      expect(relation).to receive(:published).with("yes").and_return(relation)

      siphon.with(admin: "yes", published: "yes").admin("no").published
    end
  end
end