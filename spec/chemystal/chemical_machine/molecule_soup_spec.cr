require "spec"
require "../../../src/chemystal.cr"

include Chemystal

basic_name = "basic"
wrong_name = "wrong"

molecule_1 = ->{ m! basic_name, nil }
molecule_2 = ->{ m! basic_name, 68.6 }

add_two_molecules = ->(soup : MoleculeSoup) {
  soup.add_molecule(molecule_1.call)
  soup.add_molecule(molecule_2.call)
}

describe MoleculeSoup do
  describe "add_molecule" do
    it "should be able to add molecule to its soup" do
      soup = MoleculeSoup.new

      soup.add_molecule(m! basic_name, nil)
    end

    it "should return a deque of two molecule after adding two molecule with the same name" do
      soup = MoleculeSoup.new

      add_two_molecules.call(soup)

      expected = Deque{molecule_1.call, molecule_2.call}
      soup.get_molecules_with_name(basic_name).should eq(expected)
    end

    it "should return an empty deque of two molecule after adding two molecule with a different name" do
      soup = MoleculeSoup.new

      add_two_molecules.call(soup)

      expected = Deque(Molecule).new
      soup.get_molecules_with_name(wrong_name).should eq(expected)
    end

    it "should return an empty deque of two molecule after init" do
      soup = MoleculeSoup.new

      expected = Deque(Molecule).new
      soup.get_molecules_with_name(wrong_name).should eq(expected)
    end
  end

  describe "has_molecule_with_name" do
    it "should have molecule with name after adding" do
      soup = MoleculeSoup.new

      add_two_molecules.call(soup)

      soup.has_molecule_with_name(basic_name).should be_true
    end

    it "should not have molecule with wrong name after adding" do
      soup = MoleculeSoup.new

      add_two_molecules.call(soup)

      soup.has_molecule_with_name(wrong_name).should be_false
    end
  end

  describe "use_molecule_with_name" do
    it "should return a molecule with name after adding it" do
      soup = MoleculeSoup.new

      add_two_molecules.call(soup)

      molecule = soup.use_molecule_with_name(basic_name)
      if molecule.nil?
        true.should be_false
      else
        molecule.name.should eq(basic_name)
      end
    end

    it "should not return a molecule with name after init" do
      soup = MoleculeSoup.new

      soup.use_molecule_with_name(wrong_name).should be_nil
    end

    it "should not return a molecule with wrong name after adding molecule" do
      soup = MoleculeSoup.new

      add_two_molecules.call(soup)

      soup.use_molecule_with_name(wrong_name).should be_nil
    end
  end
end
