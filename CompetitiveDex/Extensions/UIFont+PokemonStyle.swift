//
//  UIFont+PokemonStyle.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/30/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

extension UIFont {
  enum UIUserInterfaceIdiom : Int {
      case unspecified
      case phone
      case pad
  }
  
  static func boldPokemonFont(ofSize size: CGFloat) -> UIFont {
    UIDevice.current.userInterfaceIdiom == .phone
    ? UIFont.boldSystemFont(ofSize: size)
    : UIFont.boldSystemFont(ofSize: size)
  }

}
