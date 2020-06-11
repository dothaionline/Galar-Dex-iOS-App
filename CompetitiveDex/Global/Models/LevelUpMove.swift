//
//  LevelUpMove.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/7/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation

class LevelUpMove: NSObject, NSCoding, Codable {
  let level: Int
  let name: String
  
  enum Keys: String {
    case level = "level"
    case name = "name"
  }
  
  public func encode(with coder: NSCoder) {
    coder.encode(level, forKey: Keys.level.rawValue)
    coder.encode(name, forKey: Keys.name.rawValue)
  }
  
  public required convenience init?(coder: NSCoder) {
    let level = coder.decodeInteger(forKey: Keys.level.rawValue)
    guard let name = coder.decodeObject(forKey: Keys.name.rawValue) as? String
      else {
        fatalError("Unable to decode LevelUpMove")
    }
    
    self.init(level: level, name: name)
  }
  
  init(level: Int, name: String) {
    self.level = level
    self.name = name
    super.init()
  }
}
