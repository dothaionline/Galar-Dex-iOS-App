//
//  PokemonDetailsViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/30/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class PokemonDetailsController: UIViewController {
  
  // MARK: - Properties
  var detailsView: PokemonDetailsView!
  var pokemon: Pokemon!
  var pageVC: DetailsPageViewController!
  var selectedButton = 0
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    setupDetailsView()
  }
  
  private func setupDetailsView() {
    detailsView = PokemonDetailsView(frame: view.bounds)
    detailsView.translatesAutoresizingMaskIntoConstraints = false
    detailsView.configureOnLoad(withPokemon: pokemon)
    for button in detailsView.buttonsStackView.arrangedSubviews as! [UIButton] {
      button.addTarget(self, action: #selector(detailButtonTapped(_:)), for: .touchUpInside)
    }
    detailsView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    view.addSubview(detailsView)
    
    pageVC = DetailsPageViewController()
    pageVC.pokemon = self.pokemon
    pageVC.aboutPokemonViewDelegate = self
    pageVC.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(pageVC)
    pageVC.didMove(toParent: self)
    detailsView.detailsContainerView.addSubview(pageVC.view)
    
    NSLayoutConstraint.activate([
      detailsView.topAnchor.constraint(equalTo: view.topAnchor),
      detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      pageVC.view.topAnchor.constraint(equalTo: detailsView.detailsContainerView.topAnchor, constant: 8),
      pageVC.view.bottomAnchor.constraint(equalTo: detailsView.detailsContainerView.bottomAnchor),
      pageVC.view.leadingAnchor.constraint(equalTo: detailsView.detailsContainerView.leadingAnchor),
      pageVC.view.trailingAnchor.constraint(equalTo: detailsView.detailsContainerView.trailingAnchor),
    ])
  }
  
  // MARK: - UI Functionality
  @objc func closeButtonTapped() {
    dismiss(animated: true)
  }
  
  @objc func detailButtonTapped(_ sender: UIButton) {
    let direction: UIPageViewController.NavigationDirection = selectedButton < sender.tag ? .forward : .reverse
    for button in detailsView.buttonsStackView.arrangedSubviews as! [UIButton] {
      if button.tag == selectedButton {
        button.setTitleColor(.label, for: .normal)
      }
    }
    selectedButton = sender.tag
    sender.setTitleColor(.getColor(for: pokemon.types[0]), for: .normal)
    animateUnderlineView(to: sender)
    pageVC.setViewControllers([pageVC.pages[sender.tag]], direction: direction, animated: true, completion: nil)
  }
  
  // MARK: - Animation Methods
  private func animateUnderlineView(to view: UIView) {
    detailsView.underlineWidthConstraint.isActive = false
    detailsView.underlineCenterXConstraint.isActive = false
    detailsView.underlineCenterXConstraint = detailsView.underlineView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    detailsView.underlineWidthConstraint = detailsView.underlineView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.15)
    NSLayoutConstraint.activate([
      detailsView.underlineCenterXConstraint,
      detailsView.underlineWidthConstraint
    ])
    UIView.animate(withDuration: 0.2, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
}

extension PokemonDetailsController: AboutPokemonViewDelegate {
  func aboutViewDidScroll(_ scrollView: UIScrollView) {
  }

}
