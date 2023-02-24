module Chemystal
  # A Molecule Soup is a Hash from the molecules name
  # to a deque of molecules having that same name
  #
  # The use of a deque is to have FIFO, such that no old molecules
  # are left floating around in the soup
  class MoleculeSoup
    @soup = Hash(String, Deque(Molecule)).new

    # Gets all molecules with the *name*
    def get_molecules_with_name(name : String) : Deque(Molecule)
      return @soup.fetch name, Deque(Molecule).new
    end

    # Checks if at least one molecule with the *name* is in the soup
    def has_molecule_with_name(name : String) : Bool
      return get_molecules_with_name(name).size > 0
    end

    # Consumes one molecule withe the *name*, returning it and removing it from the soup
    def use_molecule_with_name(name : String) : Molecule?
      molecules_with_same_name = @soup.fetch name, nil

      if molecules_with_same_name.nil?
        return nil
      end

      return molecules_with_same_name.shift?
    end

    # Adds a molecule to the soup
    def add_molecule(molecule : Molecule)
      molecules_with_same_name = @soup.fetch molecule.name, Deque(Molecule).new
      molecules_with_same_name.push molecule

      @soup[molecule.name] = molecules_with_same_name
    end
  end
end
