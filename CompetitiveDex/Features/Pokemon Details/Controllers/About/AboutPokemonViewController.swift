//
//  AboutPokemonViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

protocol AboutPokemonViewDelegate {
  func aboutViewDidScroll(_ scrollView: UIScrollView)
}

class AboutPokemonViewController: UIViewController {
  
  var tableView: UITableView!
  var pokemon: Pokemon!
  var delegate: AboutPokemonViewDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }

}

extension AboutPokemonViewController: UITableViewDataSource, UITableViewDelegate {
  enum Section: Int, CaseIterable {
    case dexEntry = 0
    case evolutions
    case abilities
  }
  
  private func setupTableView() {
    tableView = UITableView(frame: view.bounds, style: .grouped)
    tableView.backgroundColor = .systemBackground
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(DexEntryCell.self, forCellReuseIdentifier: DexEntryCell.reuseIdentifier)
    tableView.register(EvolutionChartCell.self, forCellReuseIdentifier: EvolutionChartCell.reuseIdentifier)
    tableView.register(AbilityChartCell.self, forCellReuseIdentifier: AbilityChartCell.reuseIdentifier)
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let section = Section(rawValue: section)
    switch section {
    case .evolutions:
      return pokemon.evolutions.isEmpty ? nil : "Evolution Chart"
    case .abilities:
      return "Abilities"
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let sectionType = Section(rawValue: section)
    switch sectionType {
    case .evolutions, .abilities:
      if sectionType == .evolutions  && pokemon.evolutions.isEmpty {
        return nil
      }
      let myLabel = UILabel()
      myLabel.frame = CGRect(x: 20, y: 8, width: view.frame.width - 20, height: 30)
      myLabel.font = .boldPokemonFont(ofSize: 19)
      myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
      let headerView = UIView()
      headerView.backgroundColor = .systemBackground
      headerView.addSubview(myLabel)
      myLabel.backgroundColor = .systemBackground
      return headerView
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let sectionType = Section(rawValue: section)
    switch sectionType {
    case .dexEntry:
      return .leastNormalMagnitude
    case .evolutions:
      return pokemon.evolutions.isEmpty ? .leastNormalMagnitude : 40
    default:
      return 40
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    .leastNormalMagnitude
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let section = Section(rawValue: section)
    switch section {
    case .dexEntry:
      return pokemon.description != nil ? 1 : 0
    case .evolutions:
      return pokemon.evolutions.count > 0 ? 1 : 0
    case .abilities:
      return pokemon.abilities.count > 0 ? 1 : 0
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = Section(rawValue: indexPath.section)
    switch section {
    case .dexEntry:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: DexEntryCell.reuseIdentifier, for: indexPath) as? DexEntryCell else {
        fatalError("Unable to dequeue cell with identifier: \(DexEntryCell.reuseIdentifier)")
      }
      cell.configure(with: pokemon.description)
      return cell
    case .evolutions:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: EvolutionChartCell.reuseIdentifier, for: indexPath) as? EvolutionChartCell else {
        fatalError("Unable to dequeue cell with identifier: \(EvolutionChartCell.reuseIdentifier)")
      }
      cell.configure(withEvolutions: pokemon.evolutions)
      return cell
    case .abilities:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: AbilityChartCell.reuseIdentifier, for: indexPath) as? AbilityChartCell else {
        fatalError("Unable to dequeue cell with identifier: \(AbilityChartCell.reuseIdentifier)")
      }
      cell.configure(withAbilities: pokemon.abilities)
      return cell
    default:
      fatalError("Section does not have a defined cell")
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let section = Section(rawValue: indexPath.section)
    if section == .evolutions {
      var extraHeightMultiplier: Double = 1
      if pokemon.evolutions.count > 3 {
        extraHeightMultiplier = (Double(pokemon.evolutions.count) / 3.0).rounded(.up)
      }
      return (view.frame.width * 1/3) * CGFloat(extraHeightMultiplier) - CGFloat(10 * extraHeightMultiplier)
    }
    
    if section == .abilities {
      var extraHeightMultiplier: Double = 1
      if pokemon.abilities.count > 2 {
        extraHeightMultiplier = (Double(pokemon.abilities.count) / 2.0).rounded(.up)
      }
      return (view.frame.width * 1/6) * CGFloat(extraHeightMultiplier)
    }
    
    return UITableView.automaticDimension
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    delegate?.aboutViewDidScroll(scrollView)
  }

}
