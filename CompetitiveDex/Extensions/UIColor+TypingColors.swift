//
//  UIColor+TypingColors.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/29/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

extension UIColor {
  static let bug = UIColor(red: 196/255.0, green: 242/255.0, blue: 86/255.0, alpha: 1.0)
  static let dark = UIColor(red: 85/255.0, green: 85/255.0, blue: 100/255.0, alpha: 1.0)
  static let dragon = UIColor(red: 50/255.0, green: 107/255.0, blue: 180/255.0, alpha: 1.0)
  static let electric = UIColor(red: 248/255.0, green: 208/255.0, blue: 92/255.0, alpha: 1.0)
  static let fairy = UIColor(red: 229/255.0, green: 149/255.0, blue: 212/255.0, alpha: 1.0)
  static let fighting = UIColor(red: 198/255.0, green: 86/255.0, blue: 100/255.0, alpha: 1.0)
  static let fire = UIColor(red: 229/255.0, green: 94/255.0, blue: 63/255.0, alpha: 1.0)
  static let flying = UIColor(red: 115/255.0, green: 138/255.0, blue: 210/255.0, alpha: 1.0)
  static let ghost = UIColor(red: 132/255.0, green: 125/255.0, blue: 199/255.0, alpha: 1.0)
  static let grass = UIColor(red: 90/255.0, green: 164/255.0, blue: 84/255.0, alpha: 1.0)
  static let ground = UIColor(red: 194/255.0, green: 113/255.0, blue: 62/255.0, alpha: 1.0)
  static let ice = UIColor(red: 136/255.0, green: 211/255.0, blue: 205/255.0, alpha: 1.0)
  static let normal = UIColor(red: 162/255.0, green: 156/255.0, blue: 143/255.0, alpha: 1.0)
  static let poison = UIColor(red: 201/255.0, green: 90/255.0, blue: 188/255.0, alpha: 1.0)
  static let psychic = UIColor(red: 248/255.0, green: 88/255.0, blue: 136/255.0, alpha: 1.0)
  static let rock = UIColor(red: 199/255.0, green: 183/255.0, blue: 112/255.0, alpha: 1.0)
  static let steel = UIColor(red: 65/255.0, green: 122/255.0, blue: 140/255.0, alpha: 1.0)
  static let water = UIColor(red: 83/255.0, green: 157/255.0, blue: 248/255.0, alpha: 1.0)
  
  // MARK: - Helper Methods
  static func getColor(for pokemonType: String) -> UIColor {
    let type = pokemonType.lowercased()
    switch type {
    case "bug":
      return .bug
    case "dark":
      return .dark
    case "dragon":
      return .dragon
    case "electric":
      return .electric
    case "fairy":
      return .fairy
    case "fighting":
      return .fighting
    case "fire":
      return .fire
    case "flying":
      return .flying
    case "ghost":
      return .ghost
    case "grass":
      return .grass
    case "ground":
      return .ground
    case "ice":
      return .ice
    case "normal":
      return .normal
    case "poison":
      return .poison
    case "psychic":
      return .psychic
    case "rock":
      return .rock
    case "steel":
      return .steel
    case "water":
      return .water
    default:
      return .clear
    }
  }
}
