//
//  Nature.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/2/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation

enum Nature: String, CaseIterable {
  case Hardy
  case Lonely
  case Brave
  case Adamant
  case Naughty
  case Bold
  case Docile
  case Relaxed
  case Impish
  case Lax
  case Timid
  case Hasty
  case Serious
  case Jolly
  case Naive
  case Modest
  case Mild
  case Quiet
  case Bashful
  case Rash
  case Calm
  case Gentle
  case Sassy
  case Careful
  case Quirky
  
  func getStatBenefits() -> (Stats?, Stats?) {
    switch self {
    case .Lonely:
      return (.Attack, .Defense)
    case .Brave:
      return (.Attack, .Speed)
    case .Adamant:
      return (.Attack, .SpAtk)
    case .Naughty:
      return (.Attack, .SpDef)
    case .Bold:
      return (.Defense, .Attack)
    case .Relaxed:
      return (.Defense, .Speed)
    case .Impish:
      return (.Defense, .SpAtk)
    case .Lax:
      return (.Defense, .SpDef)
    case .Modest:
      return (.SpAtk, .Attack)
    case .Mild:
      return (.SpAtk, .Defense)
    case .Quiet:
      return (.SpAtk, .Speed)
    case .Rash:
      return (.SpAtk, .SpDef)
    case .Calm:
      return (.SpDef, .Attack)
    case .Gentle:
      return (.SpDef, .Defense)
    case .Sassy:
      return (.SpDef, .Speed)
    case .Careful:
      return (.SpDef, .SpAtk)
    case .Timid:
      return (.Speed, .Attack)
    case .Hasty:
      return (.Speed, .Defense)
    case .Jolly:
      return (.Speed, .SpAtk)
    case .Naive:
      return (.Speed, .SpDef)
    default:
      return (nil, nil)
    }
  }
}
