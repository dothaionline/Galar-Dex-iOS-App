//
//  MyTeamsController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/8/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class MyTeamsController: UITableViewController {
  
  let pokemons = [
    Pokemon(id: 0, galarDex: nil, name: "Arcanine", baseStats: [], evYield: [], abilities: [], types: ["Fire"], eggGroups: [], height: 2.2, weight: 2.2, color: "Red", eggMoves: [], levelUpMoves: [], tms: [], trs: [], evolutions: [], description: nil),
    Pokemon(id: 0, galarDex: nil, name: "Alcremie", baseStats: [], evYield: [], abilities: [], types: ["Fairy"], eggGroups: [], height: 2.2, weight: 2.2, color: "Red", eggMoves: [], levelUpMoves: [], tms: [], trs: [], evolutions: [], description: nil),
    Pokemon(id: 0, galarDex: nil, name: "Dragapult", baseStats: [], evYield: [], abilities: [], types: ["Dragon"], eggGroups: [], height: 2.2, weight: 2.2, color: "Red", eggMoves: [], levelUpMoves: [], tms: [], trs: [], evolutions: [], description: nil),
    Pokemon(id: 0, galarDex: nil, name: "Rillaboom", baseStats: [], evYield: [], abilities: [], types: ["Grass"], eggGroups: [], height: 2.2, weight: 2.2, color: "Red", eggMoves: [], levelUpMoves: [], tms: [], trs: [], evolutions: [], description: nil),
    Pokemon(id: 0, galarDex: nil, name: "Milotic", baseStats: [], evYield: [], abilities: [], types: ["Water"], eggGroups: [], height: 2.2, weight: 2.2, color: "Red", eggMoves: [], levelUpMoves: [], tms: [], trs: [], evolutions: [], description: nil),
    Pokemon(id: 0, galarDex: nil, name: "Bisharp", baseStats: [], evYield: [], abilities: [], types: ["Dark"], eggGroups: [], height: 2.2, weight: 2.2, color: "Red", eggMoves: [], levelUpMoves: [], tms: [], trs: [], evolutions: [], description: nil),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  // MARK: - Table view data source
  private func setupTableView() {
    tableView.separatorStyle = .none
    tableView.register(TeamCell.self, forCellReuseIdentifier: TeamCell.reuseIdentifier)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 3
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamCell.reuseIdentifier, for: indexPath) as? TeamCell else {
      fatalError()
    }
    cell.configure(withTeam: pokemons)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 170
  }
  
}
