require "json"

module Chemystal
  # A Molecule can take any JSON like value
  alias MoleculeValue = JSON::Any::Type

  # A Molecule is a labeled value, it is similar to a typed message
  # in message passing paradigms
  struct Molecule
    getter name, value

    def initialize(@name : String, @value : MoleculeValue)
    end
  end

  # Make a molecule
  def m!(name : String, value : MoleculeValue) : Molecule
    return Molecule.new name, value
  end
end
