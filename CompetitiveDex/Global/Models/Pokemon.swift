//
//  Pokemon.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/28/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation

class Pokemon: NSObject, Decodable, NSCoding, Comparable {
  let id: Int
  let galarDex: String?
  let name: String
  let baseStats: [Int]
  let evYield: [Int]
  let abilities: [Ability]
  let types: [String]
  let eggGroups: [String]
  let height: Double
  let weight: Double
  let color: String
  let eggMoves: [String]
  let levelUpMoves: [LevelUpMove]
  let tms: [Int]
  let trs: [Int]
  let evolutions: [Evolution]
  let dexDescription: String?
  
  enum Keys: String {
    case id = "pokemon"
    case galarDex = "ability"
    case name = "name"
    case baseStats = "evSpread"
    case evYield = "ivSpread"
    case abilities = "stats"
    case types = "types"
    case eggGroups = "eggGroups"
    case height = "height"
    case weight = "weight"
    case color = "color"
    case eggMoves = "eggMoves"
    case levelUpMoves = "levelUpMoves"
    case tms = "tms"
    case trs = "trs"
    case evolutions = "evolutions"
    case dexDescription = "dexDescription"
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case galarDex = "galar_dex"
    case name
    case baseStats = "base_stats"
    case evYield = "ev_yield"
    case abilities
    case types
    case eggGroups = "egg_groups"
    case height
    case weight
    case color
    case eggMoves = "egg_moves"
    case levelUpMoves = "level_up_moves"
    case tms
    case trs
    case evolutions
    case dexDescription = "description"
  }
  
  public func encode(with coder: NSCoder) {
    coder.encode(id, forKey: Keys.id.rawValue)
    coder.encode(galarDex, forKey: Keys.galarDex.rawValue)
    coder.encode(name, forKey: Keys.name.rawValue)
    coder.encode(baseStats, forKey: Keys.baseStats.rawValue)
    coder.encode(evYield, forKey: Keys.evYield.rawValue)
    coder.encode(abilities, forKey: Keys.abilities.rawValue)
    coder.encode(types, forKey: Keys.types.rawValue)
    coder.encode(eggGroups, forKey: Keys.eggGroups.rawValue)
    coder.encode(height, forKey: Keys.height.rawValue)
    coder.encode(weight, forKey: Keys.weight.rawValue)
    coder.encode(color, forKey: Keys.color.rawValue)
    coder.encode(eggMoves, forKey: Keys.eggMoves.rawValue)
    coder.encode(levelUpMoves, forKey: Keys.levelUpMoves.rawValue)
    coder.encode(tms, forKey: Keys.tms.rawValue)
    coder.encode(trs, forKey: Keys.trs.rawValue)
    coder.encode(evolutions, forKey: Keys.evolutions.rawValue)
    coder.encode(dexDescription, forKey: Keys.dexDescription.rawValue)
  }
  
  public required convenience init?(coder: NSCoder) {
    let id = coder.decodeInteger(forKey: Keys.id.rawValue)
    let height = coder.decodeDouble(forKey: Keys.height.rawValue)
    let weight = coder.decodeDouble(forKey: Keys.weight.rawValue)

    let galarDex = coder.decodeObject(forKey: Keys.galarDex.rawValue) as? String
    let description = coder.decodeObject(forKey: Keys.dexDescription.rawValue) as? String
    guard let name = coder.decodeObject(forKey: Keys.name.rawValue) as? String,
      let baseStats = coder.decodeObject(forKey: Keys.baseStats.rawValue) as? [Int],
      let evYield = coder.decodeObject(forKey: Keys.evYield.rawValue) as? [Int],
      let abilities = coder.decodeObject(forKey: Keys.abilities.rawValue) as? [Ability],
      let types = coder.decodeObject(forKey: Keys.types.rawValue) as? [String],
      let eggGroups = coder.decodeObject(forKey: Keys.eggGroups.rawValue) as? [String],
      let color = coder.decodeObject(forKey: Keys.color.rawValue) as? String,
      let eggMoves = coder.decodeObject(forKey: Keys.eggMoves.rawValue) as? [String],
      let levelUpMoves = coder.decodeObject(forKey: Keys.levelUpMoves.rawValue) as? [LevelUpMove],
      let tms = coder.decodeObject(forKey: Keys.tms.rawValue) as? [Int],
      let trs = coder.decodeObject(forKey: Keys.trs.rawValue) as? [Int],
      let evolutions = coder.decodeObject(forKey: Keys.evolutions.rawValue) as? [Evolution] else {
        fatalError("Failed to decode Pokemon Object")
    }
    self.init(id: id, height: height, weight: weight, galarDex: galarDex, name: name, baseStats: baseStats, evYield: evYield, abilities: abilities, types: types, eggGroups: eggGroups, color: color, eggMoves: eggMoves, levelUpMoves: levelUpMoves, tms: tms, trs: trs, evolutions: evolutions, description: description)
  }
  
  // TODO: - This init is absolutely horrendous.  Perhaps a factory will work better?
  init(id: Int, height: Double, weight: Double, galarDex: String?, name: String, baseStats: [Int], evYield: [Int], abilities: [Ability], types: [String], eggGroups: [String], color: String, eggMoves: [String], levelUpMoves: [LevelUpMove], tms: [Int], trs: [Int], evolutions: [Evolution], description: String?) {
    self.id = id
    self.height = height
    self.weight = weight
    self.galarDex = galarDex
    self.name = name
    self.baseStats = baseStats
    self.evYield = evYield
    self.abilities = abilities
    self.types = types
    self.eggGroups = eggGroups
    self.color = color
    self.eggMoves = eggMoves
    self.levelUpMoves = levelUpMoves
    self.tms = tms
    self.trs = trs
    self.evolutions = evolutions
    self.dexDescription = description
    super.init()
  }
  
  static func < (lhs: Pokemon, rhs: Pokemon) -> Bool {
    if let lhsDex = lhs.galarDex,
      let rhsDex = rhs.galarDex {
      return Int(lhsDex)! < Int(rhsDex)!
    } else if lhs.galarDex == nil && rhs.galarDex == nil {
      return false
    } else if lhs.galarDex != nil && rhs.galarDex == nil {
      return true
    } else {
      return false
    }
    
  }
  
  static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
    if let lhsDex = lhs.galarDex,
      let rhsDex = rhs.galarDex {
      return Int(lhsDex)! == Int(rhsDex)!
    }
    
    return false
    
  }
  
}
