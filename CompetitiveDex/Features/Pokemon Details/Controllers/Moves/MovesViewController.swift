//
//  MovesViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/1/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class MovesViewController: UIViewController, PokemonDetails {
  
  // MARK: - Properties
  var tableView: UITableView!
  var pokemon: Pokemon!
  var state: PokedexState = .pokedex
  var trNames: [String] = []
  var tmNames: [String] = []

  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    getTRNames()
    getTMNames()
    setupTableView()
  }
  
  // MARK: - Helper Methods
  private func getTRNames() {
    guard let trsUrl = Bundle.main.url(forResource: "trs", withExtension: "json") else {
      fatalError("Invalid URL route")
    }
    
    guard let trsData = try? Data(contentsOf: trsUrl) else {
      fatalError("Invalid URL")
    }
    
    do {
      let decoder = JSONDecoder()
      let trs = try decoder.decode([MoveDisk].self, from: trsData)
      for tr in trs {
        if pokemon.trs.contains(tr.number) {
          trNames.append(tr.name)
        }
      }
    } catch let error {
      fatalError("Failed to decode TRs data: \(error)")
    }
  }
  
  private func getTMNames() {
    guard let tmsUrl = Bundle.main.url(forResource: "tms", withExtension: "json") else {
      fatalError("Invalid URL route")
    }
    
    guard let tmsData = try? Data(contentsOf: tmsUrl) else {
      fatalError("Invalid URL")
    }
    
    do {
      let decoder = JSONDecoder()
      let tms = try decoder.decode([MoveDisk].self, from: tmsData)
      for tm in tms {
        if pokemon.tms.contains(tm.number) {
          tmNames.append(tm.name)
        }
      }
    } catch let error {
      fatalError("Failed to decode TMs data: \(error)")
    }
  }

}

// MARK: - Tableview Methods
extension MovesViewController: UITableViewDataSource, UITableViewDelegate {
  enum Section: Int, CaseIterable {
    case levelUpMoves = 0
    case eggMoves
    case trMoves
    case tmMoves
  }
  
  private func setupTableView() {
    tableView = UITableView(frame: view.bounds, style: .grouped)
    tableView.backgroundColor = .systemBackground
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(MoveChartCell.self, forCellReuseIdentifier: MoveChartCell.reuseIdentifier)
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
    case .levelUpMoves:
      return "Level Up Moves"
    case .eggMoves:
      return "Egg Moves"
    case .trMoves:
      return "TR Moves"
    case .tmMoves:
      return "TM Moves"
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let myLabel = UILabel()
    myLabel.frame = CGRect(x: 20, y: 8, width: view.frame.width - 20, height: 30)
    myLabel.font = .boldPokemonFont(ofSize: 19)
    myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
    let headerView = UIView()
    headerView.backgroundColor = .systemBackground
    headerView.addSubview(myLabel)
    myLabel.backgroundColor = .systemBackground
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let sectionType = Section(rawValue: section)
    switch sectionType {
    case .levelUpMoves:
      return pokemon.levelUpMoves.isEmpty ? .leastNormalMagnitude : 40
    case .eggMoves:
      return pokemon.eggMoves.isEmpty ? .leastNormalMagnitude : 40
    case .trMoves:
      return pokemon.trs.isEmpty ? .leastNormalMagnitude : 40
    case .tmMoves:
      return pokemon.tms.isEmpty ? .leastNormalMagnitude : 40
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
    case .levelUpMoves:
      return pokemon.levelUpMoves.count > 0 ? 1 : 0
    case .eggMoves:
      return pokemon.eggMoves.count > 0 ? 1 : 0
    case .trMoves:
      return pokemon.trs.count > 0 ? 1 : 0
    case .tmMoves:
      return pokemon.tms.count > 0 ? 1 : 0
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MoveChartCell.reuseIdentifier, for: indexPath) as? MoveChartCell else {
      fatalError("Unable to dequeue cell with identifier: \(MoveCell.reuseIdentifier)")
    }
    let section = Section(rawValue: indexPath.section)
    switch section {
    case .levelUpMoves:
      let levelUpMoves = pokemon.levelUpMoves.map({ return $0.name })
      cell.configure(withMoves: levelUpMoves)
      return cell
    case .eggMoves:
      cell.configure(withMoves: pokemon.eggMoves)
      return cell
    case .trMoves:
      cell.configure(withMoves: trNames)
      return cell
    case .tmMoves:
      cell.configure(withMoves: tmNames)
      return cell
    default:
      fatalError("Section does not have a defined cell")
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let section = Section(rawValue: indexPath.section)
    var extraHeightMultiplier: Double = 1
    if section == .levelUpMoves {
      if pokemon.levelUpMoves.count > 2 {
        extraHeightMultiplier = (Double(pokemon.levelUpMoves.count) / 2.0).rounded(.up)
      }
    }
    if section == .eggMoves {
      if pokemon.eggMoves.count > 2 {
        extraHeightMultiplier = (Double(pokemon.eggMoves.count) / 2.0).rounded(.up)
      }
    }
    if section == .trMoves {
      if pokemon.trs.count > 2 {
        extraHeightMultiplier = (Double(pokemon.trs.count) / 2.0).rounded(.up)
      }
    }
    if section == .tmMoves {
      if pokemon.tms.count > 2 {
        extraHeightMultiplier = (Double(pokemon.tms.count) / 2.0).rounded(.up)
      }
    }

    return (view.frame.width * 1/6.5) * CGFloat(extraHeightMultiplier)

  }

}
