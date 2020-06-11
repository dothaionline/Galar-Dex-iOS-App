//
//  Ability.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/6/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation

class Ability: NSObject, Codable, NSCoding {
  
  let name: String
  let hidden: Bool
  
  enum Keys: String {
    case name = "name"
    case hidden = "hidden"
  }
  
  public func encode(with coder: NSCoder) {
    coder.encode(name, forKey: Keys.name.rawValue)
    coder.encode(hidden, forKey: Keys.hidden.rawValue)
  }
  
  public required convenience init?(coder: NSCoder) {
    let hidden = coder.decodeBool(forKey: Keys.hidden.rawValue)
    guard let name = coder.decodeObject(forKey: Keys.name.rawValue) as? String
      else {
        fatalError("Unable to decode Ability")
    }
    
    self.init(name: name, hidden: hidden)
  }
  
  init(name: String, hidden: Bool) {
    self.name = name
    self.hidden = hidden
    super.init()
  }
}
