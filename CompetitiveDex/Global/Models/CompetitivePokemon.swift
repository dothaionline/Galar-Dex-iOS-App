//
//  CompetitivePokemon.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/9/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation
import UIKit

class CompetitivePokemon: NSObject, NSCoding {
  var pokemon: Pokemon
  var ability: Ability
  var nature: String
//  var evSpread: [Stats]
//  var ivSpread: [Stats]
  var moves: [String]
  
  
  enum Keys: String {
    case pokemon = "pokemon"
    case ability = "ability"
    case nature = "nature"
//    case evSpread = "evSpread"
//    case ivSpread = "ivSpread"
    case stats = "stats"
    case moves = "moves"
  }
  
  public func encode(with coder: NSCoder) {
    coder.encode(pokemon, forKey: Keys.pokemon.rawValue)
    coder.encode(ability, forKey: Keys.ability.rawValue)
    coder.encode(nature, forKey: Keys.nature.rawValue)
//    coder.encode(evSpread, forKey: Keys.evSpread.rawValue)
//    coder.encode(ivSpread, forKey: Keys.ivSpread.rawValue)
    coder.encode(moves, forKey: Keys.moves.rawValue)
  }
  
  public required convenience init?(coder: NSCoder) {
    guard let pokemon = coder.decodeObject(forKey: Keys.pokemon.rawValue) as? Pokemon,
      let ability = coder.decodeObject(forKey: Keys.ability.rawValue) as? Ability,
      let nature = coder.decodeObject(forKey: Keys.nature.rawValue) as? String,
//      let evSpread = coder.decodeObject(forKey: Keys.evSpread.rawValue) as? [Stats],
//      let ivSpread = coder.decodeObject(forKey: Keys.ivSpread.rawValue) as? [Stats],
      let moves = coder.decodeObject(forKey: Keys.moves.rawValue) as? [String]
    else {
      fatalError("Unable to decode CompetitivePokemon")
    }

    self.init(pokemon: pokemon, ability: ability, nature: nature, moves: moves)
  }
  
  init(pokemon: Pokemon, ability: Ability, nature: String, moves: [String]) {
    self.pokemon = pokemon
    self.ability = ability
    self.nature = nature
//    self.evSpread = evSpread
//    self.ivSpread = ivSpread
    self.moves = moves
    super.init()
  }
}
