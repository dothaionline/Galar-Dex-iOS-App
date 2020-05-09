//
//  DexEntryCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class DexEntryCell: UITableViewCell {
  static let reuseIdentifier = "DexEntryCell"
  
  let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    view.layer.cornerRadius = 16
    view.layer.borderColor = UIColor.label.cgColor
    view.layer.borderWidth = 2
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let entryLabel: UILabel = {
    let label = UILabel()
    label.text = "hello world"
    label.font = .systemFont(ofSize: 17, weight: .medium)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    containerView.layer.borderColor = UIColor.label.cgColor
  }
  
  // MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configure(with entry: String?) {
    entryLabel.text = entry
  }
  
  private func setupViews() {
    self.selectionStyle = .none
    self.backgroundColor = .systemBackground
    contentView.addSubview(containerView)
    containerView.addSubview(entryLabel)
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      
      entryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      entryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      entryLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      entryLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
    ])
  }
  
}
