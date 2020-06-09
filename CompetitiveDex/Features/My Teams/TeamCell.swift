//
//  TeamCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/8/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
  static let reuseIdentifier = "TeamCell"
  
  var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var pokemonTeamStackView: UIStackView = {
    let view = UIStackView()
    view.distribution = .fillEqually
    view.axis = .horizontal
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var overlayView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var teamNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Tommy's Team"
    label.textColor = .white
    label.font = .monospacedDigitSystemFont(ofSize: 24, weight: .heavy)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  public func configure(withTeam team: [Pokemon]) {
    pokemonTeamStackView.arrangedSubviews.forEach( pokemonTeamStackView.removeArrangedSubview(_:))
    for pokemon in team {
      setupPokemonView(for: pokemon)
    }
    
    if team.count < 6 {
      let missingPokemon = 6 - team.count
      for _ in 0..<missingPokemon {
        setupPokemonView(for: nil)
      }
    }
  }
  
  private func setupViews() {
    self.selectionStyle = .none
    self.separatorInset = .zero
    
    let views = [containerView, pokemonTeamStackView, overlayView, teamNameLabel]
    views.forEach({ contentView.addSubview($0) })
    setupConstraints()
  }
  
  private func setupPokemonView(for pokemon: Pokemon?) {
    let backgroundView = UIView()
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    backgroundView.backgroundColor = .darkGray
    backgroundView.clipsToBounds = true
    
    let pokemonImageView = UIImageView()
    pokemonImageView.translatesAutoresizingMaskIntoConstraints = false

    let separatorView = UIView()
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    separatorView.backgroundColor = .black
    
    if let pokemon = pokemon {
      if let pokemonImage = UIImage(named: pokemon.name) {
        pokemonImageView.image = pokemonImage
      }
      backgroundView.backgroundColor = .getColor(for: pokemon.types[0])
    } else {
      pokemonImageView.image = UIImage(named: "MissingNo")!
    }
    
    backgroundView.addSubview(pokemonImageView)
    backgroundView.addSubview(separatorView)
    NSLayoutConstraint.activate([
      pokemonImageView.heightAnchor.constraint(equalToConstant: 100),
      pokemonImageView.widthAnchor.constraint(equalToConstant: 100),
      pokemonImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
      pokemonImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
      
      separatorView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
      separatorView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
      separatorView.widthAnchor.constraint(equalToConstant: 1),
      separatorView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor)
      
    ])
    pokemonTeamStackView.addArrangedSubview(backgroundView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      pokemonTeamStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
      pokemonTeamStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      pokemonTeamStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      pokemonTeamStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      
      overlayView.topAnchor.constraint(equalTo: containerView.topAnchor),
      overlayView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      overlayView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      overlayView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      
      teamNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      teamNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
    ])
  }
  
}
