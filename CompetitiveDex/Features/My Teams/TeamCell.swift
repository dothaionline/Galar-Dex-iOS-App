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
      let backgroundView = UIView()
      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      backgroundView.backgroundColor = UIColor.getColor(for: pokemon.types[0])
      backgroundView.clipsToBounds = true
      
      let pokemonImageView = UIImageView()
      pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
      if let pokemonImage = UIImage(named: pokemon.name) {
        pokemonImageView.image = pokemonImage
      } else {
        pokemonImageView.image = UIImage(named: "MissingNo")!
      }
      backgroundView.addSubview(pokemonImageView)
      NSLayoutConstraint.activate([
        pokemonImageView.heightAnchor.constraint(equalToConstant: 100),
        pokemonImageView.widthAnchor.constraint(equalToConstant: 100),
        pokemonImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
        pokemonImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
      ])
      pokemonTeamStackView.addArrangedSubview(backgroundView)
    }
  }
  
  private func setupViews() {
    self.selectionStyle = .none
    self.separatorInset = .zero
    
    let views = [containerView, pokemonTeamStackView]
    views.forEach({ contentView.addSubview($0) })
    setupConstraints()
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
      pokemonTeamStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
  }
  
}
