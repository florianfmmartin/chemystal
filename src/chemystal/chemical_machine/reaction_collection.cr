module Chemystal
  # A Reaction Collection is a Hash from molecule names to an array
  # of reactions having that molecule as part of their requirement
  #
  # The idea behind this structure is that whenever a new molecule spawns,
  # only the array of reactions requiring the new molecule will be searched
  # for new reactions to occur
  class ReactionCollection
    @collection = Hash(String, Array(Reaction)).new
    @list = Array(Reaction).new

    def initialize(@spawner : Molecule -> Nil)
    end

    # Adds a reaction to the collection under a certain name
    private def add_reaction_under_name(molecule_name : String, reaction : Reaction)
      reaction_with_same_name = @collection.fetch molecule_name, Array(Reaction).new
      reaction_with_same_name.push reaction

      @collection[molecule_name] = reaction_with_same_name
    end

    # Gets all reactions with this requirement
    protected def get_reactions_requiring_molecule_with_name(name : String) : Array(Reaction)
      return @collection.fetch name, Array(Reaction).new
    end

    # Adds a reaction to the collection by adding it to
    # all its requirements name entries
    def add_reaction(reaction : Reaction)
      reaction.requirements.each do |requirement|
        add_reaction_under_name(requirement.name, reaction)
      end
    end

    # Runs all reactions on startup, or
    # none or one reaction if responding to a new molecule
    def find_and_run_reaction(molecule_soup : MoleculeSoup, new_molecule_name : String?)
      if new_molecule_name.is_nil?
        @list.each { |reaction| reaction.update_soup_and_run_if_fulfilled(molecule_soup) }
      else
        get_reactions_requiring_molecule_with_name(new_molecule_name)
          .each { |reaction| reaction.update_soup_and_run_if_fulfilled(molecule_soup) }
      end
    end
  end
end
