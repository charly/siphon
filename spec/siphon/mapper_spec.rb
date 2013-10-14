require "spec_helper"


describe "Siphon::Mapper", broken: true do


  describe "#yo" do

    it "does awesome stuff" do

      mapper = Siphon::Mapper.new([:active, name: "jfk", age: 18, published: true], [{name: "clinton"}, {age: "12"}, :published])


      expect(mapper.types).to eq( "" )


    end
  end
end