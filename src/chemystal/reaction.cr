module Chemystal
  alias Spawner = Molecule -> Nil
  alias ReactionRequirement = {name: String, type: String, arg: String}

  struct Reaction
    getter requirements : Array(ReactionRequirement)
    @spawner : Spawner
    @proc : Array(Molecule), Spawner -> Nil

    def initialize(@requirements, @spawner, @proc)
      names = @requirements.map { |r| r[:name] }
      args = @requirements.map { |r| r[:arg] }

      if names.size > Set.new(names).size ||
          args.size > Set.new(args).size
        raise "Reaction requirement can't the same name or arg twice"
      end
    end

    def update_soup_and_run_if_fulfilled(molecule_soup : MoleculeSoup)
      fulfilled = @requirements.all? { |requirement|
        return molecule_soup.has_molecule_with_name(requirement.name)
      }

      if fulfilled
        molecules = @requirements.map { |requirement|
          return molecule_soup.use_molecule_with_name(requirement.name)
        }

        if molecules.all? { |m| ! m.is_nil? }
          spawn do
            proc.call(molecules, @spawner)
          end
        end

        return true
      end

      return false
    end
  end

  def r!(requirements : Array(ReactionRequirement), spawner : Spawner, proc : Array(Molecule), Spawner -> Nil)
    return Reaction.new requirements, spawner, proc
  end
end
