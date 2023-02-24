module Chemystal
  # A Molecule can take all these values
  alias MoleculeValue = Bool | Char | Float64 | Int64 | Nil | String | UInt64 | Hash(MoleculeValue, MoleculeValue)

  # A Molecule is a labeled value, it is similar to a typed message
  # in message passing paradigms
  struct Molecule
    getter name, value

    def initialize(@name : String, @value : MoleculeValue)
    end
  end
end
