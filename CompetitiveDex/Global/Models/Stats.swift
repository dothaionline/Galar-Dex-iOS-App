//
//  Stats.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/2/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation

enum Stats: Int, CaseIterable {
  case HP = 0
  case Attack
  case Defense
  case SpAtk
  case SpDef
  case Speed
  
  func getString() -> String {
    switch self {
    case .HP:
      return "HP"
    case .Attack:
      return "Attack"
    case .Defense:
      return "Defense"
    case .SpAtk:
      return "Sp. Atk"
    case .SpDef:
      return "Sp. Def"
    case .Speed:
      return "Speed"
    }
  }
}
