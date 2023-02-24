require "./molecule.cr"

module Chemystal
  # A Molecule Soup is a Hash from the molecules name
  # to a deque of molecules having that same name
  #
  # The use of a deque is to have FIFO, such that no old molecules
  # are left floating around in the soup
  alias MoleculeSoup = Hash(String, Deque(Molecule))

  # A Chemical Machine has a molecule soup and a reaction collection.
  # When activated it runs reactions based on the molecules available
  # in the soup as ressources for those reactions
  class ChemicalMachine
    @molecule_soup = MoleculeSoup.new

    # Gets all molecules with the *name*
    protected def get_molecules_with_name(name : String) : Deque(Molecule)
      return @molecule_soup.fetch name, Deque(Molecule).new
    end

    # Checks if at least one molecule with the *name* is in the soup
    protected def has_molecule_with_name?(name : String) : Bool
      return get_molecules_with_name(name).size > 0
    end

    # Consumes one molecule withe the *name*, returning it and removing it from the soup
    protected def use_molecule_with_name(name : String) : Molecule | Nil
      molecules_with_same_name = @molecule_soup.fetch name, nil

      if molecules_with_same_name.nil?
        return nil
      end

      return molecules_with_same_name.shift?
    end

    # Adds a molecule to the soup
    def add_molecule(molecule : Molecule)
      molecules_with_same_name = @molecule_soup.fetch molecule.name, Deque(Molecule).new
      molecules_with_same_name.push molecule

      @molecule_soup[molecule.name] = molecules_with_same_name
    end
  end
end
