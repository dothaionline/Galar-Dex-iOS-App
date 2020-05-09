//
//  PokemonDetailsView.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/30/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class PokemonDetailsView: UIView {
  let firstTypeColorView: AngledColorView = {
    let view = AngledColorView()
    // Convert the points of iOS grid to standard grid by inversing the y's
    // y = 5x/6 - 10, equation of the line given by points (x: 0, y: -1) and (x: 12, y: 0) on a standard grid
    view.points = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1.2, y: 0), CGPoint(x: 0, y: 0)]
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let secondTypeColorView: AngledColorView = {
    let view = AngledColorView()
    // y = 5.86957 - 2.17391x, equation of the line given by points (x: 0.27, y: 0) and (x: 0.73, y: -1)
    // Calculate the intersection of the two lines and that's how we arrive at (x: 0.52771154, y: 0.56024039)
    view.points = [CGPoint(x: 0.27, y: 0), CGPoint(x: 0.52771154, y: 0.56024039), CGPoint(x: 1.2, y: 0), CGPoint(x: 0.27, y: 0)]
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let closeButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Close")!, for: .normal)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let dexNumberTextLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .boldPokemonFont(ofSize: 24)
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let pokemonImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let pokemonNameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .boldPokemonFont(ofSize: 22)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let pokemonTypeStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 3
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let buttonsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let aboutButton: UIButton = {
    let button = UIButton()
    button.tag = 0
    button.setTitle("About", for: .normal)
    button.setTitleColor(.label, for: .normal)
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.font = .boldPokemonFont(ofSize: 18)
    return button
  }()
  
  let baseStatsButton: UIButton = {
    let button = UIButton()
    button.tag = 1
    button.setTitle("Stats", for: .normal)
    button.setTitleColor(.label, for: .normal)
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.font = .boldPokemonFont(ofSize: 18)
    return button
  }()
  
  let movesButton: UIButton = {
    let button = UIButton()
    button.tag = 2
    button.setTitle("Moves", for: .normal)
    button.setTitleColor(.label, for: .normal)
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.font = .boldPokemonFont(ofSize: 18)
    return button
  }()
  
  let underlineView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let detailsContainerView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .systemBackground
      return view
  }()
  
  var underlineCenterXConstraint: NSLayoutConstraint!
  var underlineWidthConstraint: NSLayoutConstraint!
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup Methods
  private func setupViews() {
    self.backgroundColor = .systemBackground
    
    buttonsStackView.addArrangedSubview(aboutButton)
    buttonsStackView.addArrangedSubview(baseStatsButton)
    buttonsStackView.addArrangedSubview(movesButton)
    
    let views: [UIView] = [firstTypeColorView, secondTypeColorView, closeButton, dexNumberTextLabel, pokemonImageView, pokemonNameLabel, pokemonTypeStackView, buttonsStackView, underlineView, detailsContainerView]
  
    views.forEach( { self.addSubview($0)} )
    
    setupConstraints()
  }
  
  public func configureOnLoad(withPokemon pokemon: Pokemon) {
    firstTypeColorView.fillColor = .getColor(for: pokemon.types[0])
    if pokemon.types.count > 1 {
      secondTypeColorView.fillColor = .getColor(for: pokemon.types[1])
    } else {
      secondTypeColorView.backgroundColor = .clear
    }
    aboutButton.setTitleColor(.getColor(for: pokemon.types[0]), for: .normal)
    
    if let pokemonImage = UIImage(named: pokemon.name) {
      pokemonImageView.image = pokemonImage
    } else {
      pokemonImageView.image = UIImage(named: "MissingNo")!
    }
    
    if let dexNo = pokemon.galarDex {
      dexNumberTextLabel.text = "No. \(dexNo)"
    } else {
      dexNumberTextLabel.text = "Missing No."
    }
    
    pokemonNameLabel.text = pokemon.name.uppercased()
    
    for type in pokemon.types {
      let imageView = UIImageView()
      imageView.image = UIImage(named: type)!
      pokemonTypeStackView.addArrangedSubview(imageView)
      imageView.widthAnchor.constraint(equalTo: pokemonTypeStackView.heightAnchor).isActive = true
    }
    
    underlineView.backgroundColor = .getColor(for: pokemon.types[0])
  }
  
  private func setupConstraints() {
    underlineCenterXConstraint = underlineView.centerXAnchor.constraint(equalTo: aboutButton.centerXAnchor)
    underlineWidthConstraint = underlineView.widthAnchor.constraint(equalTo: aboutButton.widthAnchor, multiplier: 1.15)
    
    
    NSLayoutConstraint.activate([
      firstTypeColorView.topAnchor.constraint(equalTo: self.topAnchor),
      firstTypeColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      firstTypeColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      firstTypeColorView.bottomAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor),
      
      secondTypeColorView.topAnchor.constraint(equalTo: firstTypeColorView.topAnchor),
      secondTypeColorView.leadingAnchor.constraint(equalTo: firstTypeColorView.leadingAnchor),
      secondTypeColorView.trailingAnchor.constraint(equalTo: firstTypeColorView.trailingAnchor),
      secondTypeColorView.bottomAnchor.constraint(equalTo: firstTypeColorView.bottomAnchor),
      
      closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
      closeButton.centerYAnchor.constraint(equalTo: dexNumberTextLabel.centerYAnchor),
      closeButton.heightAnchor.constraint(equalToConstant: 30),
      closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
      
      dexNumberTextLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
      dexNumberTextLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
      
      pokemonImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.53),
      pokemonImageView.heightAnchor.constraint(equalTo: pokemonImageView.widthAnchor),
      pokemonImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 38),
      pokemonImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
      
      pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 8),
      pokemonNameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
      
      pokemonTypeStackView.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 5),
      pokemonTypeStackView.heightAnchor.constraint(equalToConstant: 30),
      pokemonTypeStackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
      
      buttonsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
      buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      buttonsStackView.topAnchor.constraint(equalTo: pokemonTypeStackView.bottomAnchor, constant: 8),
      
      underlineCenterXConstraint,
      underlineWidthConstraint,
      underlineView.topAnchor.constraint(equalTo: aboutButton.bottomAnchor, constant: -4),
      underlineView.heightAnchor.constraint(equalToConstant: 2),
      
      baseStatsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      
      detailsContainerView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 0),
      detailsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      detailsContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      detailsContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      
    ])
  }
  
}
