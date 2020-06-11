//
//  Evolution.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/28/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation

class Evolution: NSObject, NSCoding, Decodable {
  let name: String
  let method: String
  
  enum Keys: String {
    case name = "name"
    case method = "method"
  }
  
  public func encode(with coder: NSCoder) {
    coder.encode(name, forKey: Keys.name.rawValue)
    coder.encode(method, forKey: Keys.method.rawValue)
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "species"
    case method
  }
  
  public required convenience init?(coder: NSCoder) {
    guard let name = coder.decodeObject(forKey: Keys.name.rawValue) as? String,
    let method = coder.decodeObject(forKey: Keys.method.rawValue) as? String
      else {
        fatalError("Unable to decode Evolution")
    }
    
    self.init(name: name, method: method)
  }
  
  init(name: String, method: String) {
    self.name = name
    self.method = method
    super.init()
  }
}
