require "./molecule.cr"

module Chemystal
  # A Chemical Machine has a molecule soup and a reaction collection.
  # When activated it runs reactions based on the molecules available
  # in the soup as ressources for those reactions
  class ChemicalMachine
    # The soup of molecule
    @molecule_soup = MoleculeSoup.new

    # Spawner of new molecules
    @molecule_spawner : Molecule -> Nil

    # Receiver of new molecules
    @molecule_receiver : Proc(Molecule?)

    # The collection of reactions
    @reaction_collection : ReactionCollection

    def initialize()
      spawn_channel = Channel(Molecule).new
      split_channel = channel_split_sender_receiver spawn_channel

      @molecule_spawner = split_channel[:sender]
      @molecule_receiver = split_channel[:receiver]

      @reaction_collection = ReactionCollection.new @molecule_spawner
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

    # Runs the chemical machine
    def run

    end
  end

  def channel_split_sender_receiver(channel)
    return {
      sender: ->channel.send(Molecule),
      receiver: ->channel.receive?
    }
  end
end
