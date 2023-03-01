require "spec"
require "../../src/chemystal.cr"

include Chemystal

nil_spawner = ->(m : Molecule) {}
nil_reaction_proc = ->(a : Array(Molecule), s : Spawner) {}

describe Reaction do
  it "should be initializable to an non nil struct" do
    object = Reaction.new([
      {name: "basic", type: "Nil", arg: "basic"},
      {name: "counter", type: "Int64", arg: "n"},
    ], nil_spawner, nil_reaction_proc)
    object.should_not be_nil
  end
end
