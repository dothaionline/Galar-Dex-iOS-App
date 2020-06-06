//
//  PokedexCollectionViewCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/28/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class PokedexCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "PokedexCell"
  
  // MARK: - Subviews
  let secondaryTypeColor: AngledColorView = {
    let view = AngledColorView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .boldPokemonFont(ofSize: 18)
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let dexLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .boldPokemonFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let pokemonImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup Methods
  public func configure(withPokemon pokemon: Pokemon) {
    nameLabel.text = pokemon.name
    dexLabel.text = pokemon.galarDex != nil ? "No. \(pokemon.galarDex!)" : ""
    if let pokemonImage = UIImage(named: pokemon.name) {
      pokemonImageView.image = pokemonImage
    } else {
      pokemonImageView.image = UIImage(named: "MissingNo")!
    }

    backgroundColor = .getColor(for: pokemon.types[0])
    if pokemon.types.count > 1 {
      secondaryTypeColor.fillColor = .getColor(for: pokemon.types[1])
    } else {
      secondaryTypeColor.fillColor = .clear
    }
  }
  
  private func setupViews() {
    self.layer.cornerRadius = 16
    self.clipsToBounds = true
    let views: [UIView] = [secondaryTypeColor, nameLabel, dexLabel, pokemonImageView]
    views.forEach({ self.addSubview($0) })
    NSLayoutConstraint.activate([
      secondaryTypeColor.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      secondaryTypeColor.topAnchor.constraint(equalTo: self.topAnchor),
      secondaryTypeColor.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      secondaryTypeColor.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
      nameLabel.trailingAnchor.constraint(equalTo: pokemonImageView.leadingAnchor),
      nameLabel.topAnchor.constraint(equalTo: dexLabel.bottomAnchor, constant: 2),
      nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      
      dexLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
      
      pokemonImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
      pokemonImageView.widthAnchor.constraint(equalTo: pokemonImageView.heightAnchor),
      pokemonImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      pokemonImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
  
}
