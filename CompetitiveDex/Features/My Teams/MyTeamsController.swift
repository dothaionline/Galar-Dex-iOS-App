//
//  MyTeamsController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/8/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import CoreData
import UIKit

class MyTeamsController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupTableView()
    TeamsManager.loadTeams()
    tableView.reloadData()
  }
  
  private func setupNavigationBar() {
    title = "My Teams"
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTeamAlert))
  }
  
  // MARK: - Helper Methods
  @objc private func showAddTeamAlert() {
    let alertController = UIAlertController(title: "Enter Team Name", message: nil, preferredStyle: .alert)
    alertController.addTextField { textfield in
      textfield.placeholder = "Team #\(TeamsManager.teams.count + 1)"
    }
    let addAction = UIAlertAction(title: "Add", style: .default, handler: { [weak alertController] _ in
      guard let textfield = alertController?.textFields?[0] else {
        fatalError("No textfield exists")
      }
      TeamsManager.saveNewTeam(withName: textfield.text!)
      self.tableView.reloadData()
    })
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(addAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
  
  // MARK: - Table view data source
  private func setupTableView() {
    tableView.separatorStyle = .none
    tableView.register(TeamCell.self, forCellReuseIdentifier: TeamCell.reuseIdentifier)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TeamsManager.teams.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let team = TeamsManager.teams[indexPath.row]
    let pokemons = TeamsManager.getPokemons(for: team)
    let teamName = TeamsManager.getName(for: team)
    let teamDetailsController = TeamDetailsController()
    teamDetailsController.teamName = teamName
    teamDetailsController.pokemons = pokemons
    teamDetailsController.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(teamDetailsController, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamCell.reuseIdentifier, for: indexPath) as? TeamCell else {
      fatalError()
    }
    let competitivePokemons = TeamsManager.getPokemons(for: TeamsManager.teams[indexPath.row])
    let pokemons = competitivePokemons.map({return $0.pokemon})
    cell.configure(withTeam: pokemons, name: TeamsManager.getName(for: TeamsManager.teams[indexPath.row]))
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 170
  }
  
}
