//
//  PokemonTabBarController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/8/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class PokemonTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Pokedex View Controller
    let pokedexController = PokedexController()
    let navigationPokedexController = UINavigationController(rootViewController: pokedexController)
    navigationPokedexController.navigationBar.backgroundColor = .clear
    navigationPokedexController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
    // My Teams View Controller
    let myTeamsController = MyTeamsController()
    let navigationTeamsController = UINavigationController(rootViewController: myTeamsController)
    navigationTeamsController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    // Add controllers to tab bar
    let tabBarList = [navigationPokedexController, navigationTeamsController]
    viewControllers = tabBarList
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
