

describe Siphon do

  describe "#new" do

    it "shoot a Siphon::Base instance" do
      expect(Siphon.apply_scope).to be_an_instance_of(Siphon::Base)
    end
  end
end