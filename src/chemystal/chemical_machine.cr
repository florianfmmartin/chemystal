require "./molecule.cr"

module Chemystal
  # A Chemical Machine has a molecule soup and a reaction collection.
  # When activated it runs reactions based on the molecules available
  # in the soup as ressources for those reactions
  class ChemicalMachine
    # The soup of molecule
    @molecule_soup = MoleculeSoup.new

    # The molecule spawning channel
    @spawn_channel = Channel(Molecule).new

    # The collection of reactions
    @reaction_collection = Hash(String, Array(Reaction)).new

    # Sends a molecule on the spawning channel
    protected def spawn_molecule(molecule : Molecule)
      @spawn_channel.send molecule
    end

    # Returns the molecule soup
    protected def get_molecule_soup
      return @molecule_soup
    end

    # Adds a molecule to the soup
    def add_molecule(molecule : Molecule)
      @molecule_soup.add_molecule molecule
    end

    # Adds a reaction to the collection
    def add_reaction(reaction : Reaction)
      @reaction_collection.add_reaction reaction
    end

    def run

    end
  end
end
