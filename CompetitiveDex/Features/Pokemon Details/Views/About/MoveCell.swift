//
//  Ability.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class MoveCell: UICollectionViewCell {
  static let reuseIdentifier = "MoveCell"
  
  let moveLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 21)
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
  
  public func configure(withMove move: String) {
    print("Move: \(move)")
    moveLabel.text = move
  }
  
  private func setupViews() {
    self.backgroundColor = .systemBackground
    contentView.addSubview(moveLabel)
    contentView.layer.cornerRadius = 16
    contentView.layer.borderColor = UIColor.label.cgColor
    contentView.layer.borderWidth = 2
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      moveLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      moveLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
      moveLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }
  
}
