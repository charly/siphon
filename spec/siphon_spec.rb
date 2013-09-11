require "spec_helper"

class Controller
  include Siphon
end

describe Siphon do
  let(:ctrl) {Controller.new}

  describe "#new" do
    it "shoot a Siphon::Base instance" do
      expect(ctrl.siphon("")).to be_an_instance_of(Siphon::Base)
    end
  end
end