//
//  AbilityChartCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class AbilityChartCell: UITableViewCell {
  static let reuseIdentifier = "AbilityChartCell"
  
  var abilities: [Ability] = []
  
  let collectionView: UICollectionView = {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0))
    
    let abilityItem = NSCollectionLayoutItem(layoutSize: itemSize)
    abilityItem.contentInsets = NSDirectionalEdgeInsets(
      top: 5,
      leading: 10,
      bottom: 5,
      trailing: 10)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(1/6))
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: abilityItem,
      count: 2
    )

    let section = NSCollectionLayoutSection(group: group)
    let layout = UICollectionViewCompositionalLayout(section: section)
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  
  // MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configure(withAbilities abilities: [Ability]) {
    self.abilities = abilities
  }
  
  private func setupViews() {
    self.selectionStyle = .none
    self.backgroundColor = .systemBackground
    collectionView.backgroundColor = .systemBackground
    collectionView.register(AbilityCell.self, forCellWithReuseIdentifier: AbilityCell.reuseIdentifier)
    collectionView.isScrollEnabled = false
    collectionView.delegate = self
    collectionView.dataSource = self
    contentView.addSubview(collectionView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
    ])
  }
  
}

extension AbilityChartCell: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return abilities.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AbilityCell.reuseIdentifier, for: indexPath) as! AbilityCell
    cell.configure(withAbility: abilities[indexPath.row])
    return cell
  }
  
  
}

