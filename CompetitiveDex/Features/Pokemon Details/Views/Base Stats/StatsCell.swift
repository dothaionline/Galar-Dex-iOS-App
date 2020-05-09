//
//  StatsTableViewCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/2/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class StatsCell: UITableViewCell {
  static let reuseIdentifier = "StatsCell"
  
  let statLabel: UILabel = {
    let label = UILabel()
    label.font = .boldPokemonFont(ofSize: 16)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let baseStatLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let barView: UIProgressView = {
    let view = UIProgressView(progressViewStyle: .bar)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(red: 99/255.0, green: 197/255.0, blue: 191/255.0, alpha: 1)
    view.layer.cornerRadius = 1.5
    return view
  }()
  
  let calculatedStatLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.textAlignment = .right
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
  
  public func configure(for stat: Stats, baseStat: Int, calculatedStat: Int, maxStat: Int, andColor color: UIColor) {
    statLabel.text = stat.getString()
    baseStatLabel.text = "\(baseStat)"
    calculatedStatLabel.text = "\(calculatedStat)"
    barView.progressTintColor = color
    barView.progress = Float(calculatedStat) / Float(maxStat)
  }
  
  private func setupViews() {
    self.selectionStyle = .none
    self.separatorInset = .zero
    let views = [statLabel, baseStatLabel, barView, calculatedStatLabel]
    views.forEach({ contentView.addSubview($0) })
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      statLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      statLabel.widthAnchor.constraint(equalToConstant: 61),
      statLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      baseStatLabel.leadingAnchor.constraint(equalTo: statLabel.trailingAnchor, constant: 8),
      baseStatLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      barView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      barView.heightAnchor.constraint(equalToConstant: 2),
      barView.leadingAnchor.constraint(equalTo: baseStatLabel.trailingAnchor, constant: 8),
      barView.trailingAnchor.constraint(equalTo: calculatedStatLabel.leadingAnchor, constant: -16),
    
      calculatedStatLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      calculatedStatLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
    ])
  }
  
}
