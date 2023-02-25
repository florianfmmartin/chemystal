module Chemystal
  alias Spawner = Molecule -> Nil
  alias ReactionRequirement = {name: String, type: String, arg: String}

  struct Reaction
    getter requirements : Array(ReactionRequirement)
    @spawner : Spawner
    @proc : Array(Molecule), Spawner -> Nil

    def initialize(@requirements, @spawner, @proc)
    end
  end
end
