require "spec"
require "../../src/chemystal.cr"

include Chemystal

basic_name = "basic"
basic_value = nil

basic_molecule = ->{ m! basic_name, basic_value }

describe Molecule do
  it "should create an object" do
    object = basic_molecule.call
    object.should_not be_nil
  end

  it "should have the correct name and value after creating object" do
    object = basic_molecule.call
    object.name.should eq(basic_name)
    object.value.should eq(basic_value)
  end

  it "should support complex types and not fail" do
    object = m! "complex", {"yo" => [1, 2, 3], "yoo" => [2, 3, 4]}.to_json
    object.should_not be_nil
  end
end
