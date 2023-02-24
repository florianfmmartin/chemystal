module Chemystal
  alias MoleculeValue = Bool | Char | Float64 | Int64 | Nil | String | UInt64

  struct Molecule
    getter name, value

    def initialize(@name : Symbol, @value : MoleculeValue)
    end
  end
end
