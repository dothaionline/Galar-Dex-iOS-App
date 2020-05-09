//
//  EvolutionCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class EvolutionCell: UICollectionViewCell {
  static let reuseIdentifier = "EvolutionCell"
  
  // MARK: - Subviews
  let evolutionImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let evolutionName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldPokemonFont(ofSize: 14)
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    contentView.layer.borderColor = UIColor.label.cgColor
  }
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  public func configure(withEvolutiion evolution: Evolution) {
    if let image = UIImage(named: evolution.name.replacingOccurrences(of: "-0", with: "")) {
      evolutionImageView.image = image
    } else {
      evolutionImageView.image = UIImage(named: "MissingNo")!
    }
    evolutionName.text = evolution.name.replacingOccurrences(of: "-0", with: "")
  }
  
  private func setupViews() {
    self.backgroundColor = .systemBackground
    contentView.addSubview(evolutionImageView)
    contentView.addSubview(evolutionName)
    contentView.layer.cornerRadius = 16
    contentView.layer.borderColor = UIColor.label.cgColor
    contentView.layer.borderWidth = 2
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      evolutionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      evolutionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      evolutionImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
      evolutionImageView.widthAnchor.constraint(equalTo: evolutionImageView.heightAnchor),
      
      evolutionName.topAnchor.constraint(equalTo: evolutionImageView.bottomAnchor, constant: 4),
      evolutionName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
      evolutionName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }
  
}
