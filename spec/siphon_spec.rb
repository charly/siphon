

describe Siphon do

  describe "#new" do

    it "shoot a Siphon::Base instance" do
      Siphon.apply.should be_an_instance_of(Siphon::Base)
    end
  end
end