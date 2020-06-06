//
//  Pokemon.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/28/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation

struct Pokemon: Decodable, Comparable {
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
  let tms: [Int]
  let trs: [Int]
  let evolutions: [Evolution]
  let description: String?
  
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
    case tms
    case trs
    case evolutions
    case description
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
