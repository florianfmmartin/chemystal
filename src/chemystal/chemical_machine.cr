require "./molecule.cr"

module Chemystal
  alias MoleculeSoup = Hash(Symbol, Deque(Molecule))

  class ChemicalMachine
    @molecule_soup = MoleculeSoup.new

    protected def get_molecules_with_name(name : Symbol) : Deque(Molecule)
      return @molecule_soup.fetch name, Deque(Molecule).new
    end

    protected def has_molecule_with_name?(name : Symbol) : Bool
      return get_molecules_with_name(name).size > 0
    end

    protected def use_molecule_with_name(name : Symbol) : Molecule | Nil
      molecules_with_same_name = @molecule_soup.fetch name, nil

      if molecules_with_same_name.nil?
        return nil
      end

      return molecules_with_same_name.pop?
    end

    def add_molecule(molecule : Molecule)
      molecules_with_same_name = @molecule_soup.fetch molecule.name, Deque(Molecule).new
      molecules_with_same_name.push molecule

      @molecule_soup[molecule.name] = molecules_with_same_name
    end
  end
end
