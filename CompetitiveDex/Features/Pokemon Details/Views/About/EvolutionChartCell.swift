//
//  EvolutionChartCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class EvolutionChartCell: UITableViewCell {
  static let reuseIdentifier = "EvolutionChartCell"
  
  var evolutions: [Evolution] = []
  
  let collectionView: UICollectionView = {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0))
    
    let evolutionItem = NSCollectionLayoutItem(layoutSize: itemSize)
    evolutionItem.contentInsets = NSDirectionalEdgeInsets(
      top: 5,
      leading: 10,
      bottom: 5,
      trailing: 10)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(1/3))
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: evolutionItem,
      count: 3
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
  
  public func configure(withEvolutions evolutions: [Evolution]) {
    self.evolutions = evolutions
  }
  
  private func setupViews() {
    self.selectionStyle = .none
    self.backgroundColor = .systemBackground
    collectionView.backgroundColor = .systemBackground
    collectionView.register(EvolutionCell.self, forCellWithReuseIdentifier: EvolutionCell.reuseIdentifier)
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

extension EvolutionChartCell: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return evolutions.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvolutionCell.reuseIdentifier, for: indexPath) as! EvolutionCell
    cell.configure(withEvolutiion: evolutions[indexPath.row])
    return cell
  }
  
  
}

