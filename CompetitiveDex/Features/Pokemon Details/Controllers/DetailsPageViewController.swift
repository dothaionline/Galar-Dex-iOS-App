//
//  DetailsPageViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

protocol PokemonDetails: UIViewController {
  var pokemon: Pokemon! { get set }
  var state: PokedexState { get set }
}

class DetailsPageViewController: UIPageViewController, PokemonDetails {
  
  var pages: [PokemonDetails] = [AboutPokemonViewController(), BaseStatsViewController(), MovesViewController()]
  var pokemon: Pokemon!
  var state: PokedexState = .pokedex
  var aboutPokemonViewDelegate: AboutPokemonViewDelegate?
  
  override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    for (index, controller) in pages.enumerated() {
      controller.pokemon = self.pokemon
      controller.state = self.state
      controller.view.tag = index
      if let controller = controller as? AboutPokemonViewController {
        controller.delegate = aboutPokemonViewDelegate
      }
    }
    
    setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
  }
  
}
