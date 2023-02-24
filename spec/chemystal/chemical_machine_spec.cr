require "spec"
require "../../src/chemystal.cr"

include Chemystal

describe ChemicalMachine do
  it "should create an object" do
    object = ChemicalMachine.new

    object.should_not be_nil
  end
end
