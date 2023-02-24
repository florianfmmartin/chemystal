require "spec"
require "../../src/chemystal.cr"

include Chemystal

molecule_1 = ->{ Molecule.new :basic, nil }
molecule_2 = ->{ Molecule.new :basic, 68.6 }

add_two_molecules = ->(chem : ChemicalMachine) {
  chem.add_molecule(molecule_1.call)
  chem.add_molecule(molecule_2.call)
}

describe ChemicalMachine do
  describe "intialize" do
    it "should create an object" do
      object = ChemicalMachine.new

      object.should_not be_nil
    end
  end

  describe "add_molecule" do
    it "should be able to add molecule to its soup" do
      chem = ChemicalMachine.new

      chem.add_molecule(Molecule.new :basic, nil)
    end

    it "should return a deque of two molecule after adding two molecule with the same name" do
      chem = ChemicalMachine.new

      add_two_molecules.call(chem)

      expected = Deque{molecule_1.call, molecule_2.call}
      chem.get_molecules_with_name(:basic).should eq(expected)
    end

    it "should return an empty deque of two molecule after adding two molecule with a different name" do
      chem = ChemicalMachine.new

      add_two_molecules.call(chem)

      expected = Deque(Molecule).new
      chem.get_molecules_with_name(:not_added).should eq(expected)
    end

    it "should return an empty deque of two molecule after init" do
      chem = ChemicalMachine.new

      expected = Deque(Molecule).new
      chem.get_molecules_with_name(:not_added).should eq(expected)
    end
  end

  describe "has_molecule_with_name?" do
    it "should have molecule with name after adding" do
      chem = ChemicalMachine.new

      add_two_molecules.call(chem)

      chem.has_molecule_with_name?(:basic).should be_true
    end

    it "should not have molecule with wrong name after adding" do
      chem = ChemicalMachine.new

      add_two_molecules.call(chem)

      chem.has_molecule_with_name?(:not_added).should be_false
    end
  end

  describe "use_molecule_with_name" do
    it "should return a molecule with name after adding it" do
      chem = ChemicalMachine.new

      add_two_molecules.call(chem)

      molecule = chem.use_molecule_with_name(:basic)
      if molecule.nil?
        true.should be_false
      else
        molecule.name.should eq(:basic)
      end
    end

    it "should not return a molecule with name after init" do
      chem = ChemicalMachine.new

      chem.use_molecule_with_name(:not_added).should be_nil
    end

    it "should not return a molecule with wrong name after adding molecule" do
      chem = ChemicalMachine.new

      add_two_molecules.call(chem)

      chem.use_molecule_with_name(:not_added).should be_nil
    end
  end
end
