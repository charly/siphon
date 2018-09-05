require "spec_helper"


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

  describe "#with", broken: true do

    it "returns proxy" do
      siphon = Siphon::Base.new("")

      expect(siphon.with({published: nil})).to be_kind_of(Siphon::Proxy)
    end

    it "sets params" do
      siphon = Siphon::Base.new("").with(published: :integer)

      expect(siphon.params).to eq(published: :integer)
    end
  end

  describe "#proxy", broken: true do
    it "handles the scope calls" do
      relation = double
      siphon = Siphon::Base.new(relation)


      expect(relation).to receive(:admin).with("yes").and_return(relation)
      expect(relation).to receive(:published).with("yes").and_return(relation)

      siphon.with(admin: "yes", published: "yes").admin("no").published
    end
  end

  describe "#recall", broken: true do
    it "exposes a proxy whose method_missing will record calls to be recalled conditionally" do
      relation = double
      expect(relation).to receive(:admin).with("yes").and_return(relation)
      expect(relation).to receive(:published).with("yes").and_return(relation)

      Siphon::Base.new(relation).recall.admin("no").published.when({admin: "yes", published: "yes"})
    end
  end

  describe "functional testing", broken: true  do
    it "kinda works" do
      relation = double
      formobj = Formobj.new(admin: true, after: 1950, name: "")

      expect(relation).to receive(:admin).with(true).and_return(relation)
      expect(relation).to receive(:after).with(1950).and_return(relation)

      Siphon::Base.new(relation).admin(false).after(1).scope(formobj)
    end
  end
end
