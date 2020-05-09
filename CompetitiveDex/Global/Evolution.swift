//
//  Evolution.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/28/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import Foundation

struct Evolution: Decodable {
  let name: String
  let method: String
  
  enum CodingKeys: String, CodingKey {
    case name = "species"
    case method
  }
}
