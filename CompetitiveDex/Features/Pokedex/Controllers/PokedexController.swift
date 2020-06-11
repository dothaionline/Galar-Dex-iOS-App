//
//  PokedexController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/28/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit


enum PokedexState {
  case pokedex
  case addPokemon
}

class PokedexController: UIViewController {
  
  var pokemon: [Pokemon] = []
  var state: PokedexState = .pokedex // Change this to addPokemon before presenting if you want to show add Pokemon Screen
  private let spacing: CGFloat = 16.0

  var collectionView: UICollectionView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupCollectionView()
    getPokemon()
    // Do any additional setup after loading the view.
  }
  
  // MARK: - Setup Methods
  private func setupNavigationBar() {
    switch state {
    case .pokedex:
      title = "Galar Pokedex"
    case .addPokemon:
      title = "Select a Pokemon"
    }
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  // MARK: - Helper Methods
  private func getPokemon() {
    guard let url = Bundle.main.url(forResource: "swshpokemon", withExtension: "json") else {
      fatalError("Unable to locate swshpokemon.json in Bundle")
    }
    
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Invalid URL")
    }
    
    do {
      let decoder = JSONDecoder()
      pokemon = try decoder.decode([Pokemon].self, from: data)
      pokemon.sort(by: <)
      collectionView.reloadData()
    } catch let error {
      fatalError("Failed to decode Pokemon data: \(error)")
    }
  }
  
}

// MARK: - CollectionView Methods
extension PokedexController: UICollectionViewDataSource, UICollectionViewDelegate {
  func setupCollectionView() {
    let layout = generateLayout()
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(PokedexCollectionViewCell.self, forCellWithReuseIdentifier: PokedexCollectionViewCell.reuseIdentifier)
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemon.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCollectionViewCell.reuseIdentifier, for: indexPath) as! PokedexCollectionViewCell
    cell.configure(withPokemon: pokemon[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailsController = PokemonDetailsController()
    detailsController.pokemon = pokemon[indexPath.row]
    detailsController.state = state
    detailsController.modalPresentationStyle = .fullScreen
    present(detailsController, animated: true)
  }
  
  func generateLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    
    let pokedexItem = NSCollectionLayoutItem(layoutSize: itemSize)
    pokedexItem.contentInsets = NSDirectionalEdgeInsets(
      top: 6,
      leading: 6,
      bottom: 4,
      trailing: 6
    )
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(1/3))
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: pokedexItem,
      count: 2
    )

    let section = NSCollectionLayoutSection(group: group)
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  
}
