require "spec_helper"


describe Formobj, idle: true do
  describe "#attributes" do
    it "returns a hash" do
      formobj = Formobj.new(name: "proust", admin: "true", after: "1800")

      expect(formobj.attributes).to be_a(Hash)
    end

    it "includes attributes not passed in initializer" do
      formobj = Formobj.new(name: "proust")

      expect(formobj.attributes.keys).to include(:admin, :order, :after)
      # expect(formobj.attributes).to eq("blza")
    end

    it "does not include PORO attributes (attr_accessor)" do
      formobj = Formobj.new(name: "proust")

      expect(formobj.attributes.keys).to_not include(:sinfull)
    end

    context "when params.value's empty strings" do
      it "returns empty string"  do
        formobj = Formobj.new(name: "", admin: "", after: "")

        expect(formobj.name).to eq ""
        expect(formobj.after).to eq ""
        expect(formobj.admin).to eq ""
      end
    end

    context "when params.value's nil" do
      it "returns nil"  do
        formobj = Formobj.new(name: nil, admin: nil, after: nil)

        expect(formobj.name).to eq nil
        expect(formobj.after).to eq nil
        expect(formobj.admin).to eq nil
      end
    end

    context "when param is not present" do
      it "returns default values"  do
        formobj = Formobj.new()

        expect(formobj.name).to eq "nabokov"
        expect(formobj.after).to eq 1950
        expect(formobj.admin).to eq false
      end
    end

    context "when params.value has string values" do
      it "returns typecasted values"  do
        formobj = Formobj.new(name: "proust", admin: "true", after: "1800")

        expect(formobj.name).to eq "proust"
        expect(formobj.after).to eq 1800
        expect(formobj.admin).to eq true
      end

      it "returns true with '1' " do
        formobj = Formobj.new(admin: "1")
        expect(formobj.admin).to eq true
      end

      it "DOES NOT RETURN TRUE with 'random' " do
        formobj = Formobj.new(admin: "random")
        expect(formobj.admin).to_not eq true
      end

      it "returns false with 'false' " do
        formobj = Formobj.new(admin: "false")
        expect(formobj.admin).to eq false
      end

      it "returns false with '0' " do
        formobj = Formobj.new(admin: "0")
        expect(formobj.admin).to eq false
      end
    end
  end

end