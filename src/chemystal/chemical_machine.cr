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

    # Sends a molecule on the spawning channel
    protected def spawn_molecule(molecule : Molecule)
      @spawn_channel.send molecule
    end

    # Adds a molecule to the soup
    def add_molecule(molecule : Molecule)
      @molecule_soup.add_molecule molecule
    end

    protected def get_molecule_soup()
      return @molecule_soup
    end

    # TODO: add reaction soup
    def run()
    end
  end
end
