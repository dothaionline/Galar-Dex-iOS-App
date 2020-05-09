//
//  DetailsPageViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class DetailsPageViewController: UIPageViewController {
  
  var pages: [UIViewController] = [UIViewController]()
  var pokemon: Pokemon!
  var aboutPokemonViewDelegate: AboutPokemonViewDelegate?
  
  override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // instantiate "pages"
    let vc = AboutPokemonViewController()
    vc.pokemon = self.pokemon
    vc.delegate = aboutPokemonViewDelegate
    vc.view.tag = 0
    
    let vc2 = BaseStatsViewController()
    vc2.pokemon = pokemon
    vc2.view.tag = 1
    
    let vc3 = MovesViewController()
    vc3.view.tag = 2
    pages.append(vc)
    pages.append(vc2)
    pages.append(vc3)
    
    setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
  }
  
}
