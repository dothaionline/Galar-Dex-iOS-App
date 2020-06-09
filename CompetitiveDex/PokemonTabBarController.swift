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
    let pokedexController = PokedexController()
    let navigationController = UINavigationController(rootViewController: pokedexController)
    navigationController.navigationBar.backgroundColor = .clear
    navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    // Do any additional setup after loading the view.
    let tabBarList = [navigationController]
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
