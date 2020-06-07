//
//  AbilityChartCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class MoveChartCell: UITableViewCell {
  static let reuseIdentifier = "MoveChartCell"
  
  var moves: [String] = []
  
  let collectionView: UICollectionView = {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0))
    
    let moveItem = NSCollectionLayoutItem(layoutSize: itemSize)
    moveItem.contentInsets = NSDirectionalEdgeInsets(
      top: 5,
      leading: 10,
      bottom: 5,
      trailing: 10)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(1/6))
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: moveItem,
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
  
  public func configure(withMoves moves: [String]) {
    self.moves = moves
    collectionView.reloadData()
    collectionView.collectionViewLayout.invalidateLayout()
  }
  
  private func setupViews() {
    self.selectionStyle = .none
    self.backgroundColor = .systemBackground
    collectionView.backgroundColor = .systemBackground
    collectionView.register(MoveCell.self, forCellWithReuseIdentifier: MoveCell.reuseIdentifier)
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

extension MoveChartCell: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return moves.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoveCell.reuseIdentifier, for: indexPath) as! MoveCell
    cell.configure(withMove: moves[indexPath.row])
    return cell
  }
  
  
}

