//
//  TeamDetailsController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/10/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class TeamDetailsController: UITableViewController {
  
  public var teamName: String?
  public var pokemons: [CompetitivePokemon]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
  }
  
  private func setupNavigationBar() {
    title = teamName
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
  }
  
  // MARK: - Functionality Methods
  @objc private func addButtonTapped() {
    if pokemons.count < 6 {
      showPokedexScreen()
    } else {
      showMaxPokemonAllowedAlert()
    }
  }
  
  private func showPokedexScreen() {
    let pokedexController = PokedexController()
    pokedexController.state = .addPokemon
    navigationController?.pushViewController(pokedexController, animated: true)
  }
  
  private func showMaxPokemonAllowedAlert() {
    let alertController = UIAlertController(title: nil, message: "You may only have up to 6 pokemon per team.  Please remove a pokemon before you add another", preferredStyle: .alert)
    present(alertController, animated: true)
  }
  
  // MARK: - TableView Methods
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokemons.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = pokemons[indexPath.row].pokemon.name
    return cell
  }
  
}
