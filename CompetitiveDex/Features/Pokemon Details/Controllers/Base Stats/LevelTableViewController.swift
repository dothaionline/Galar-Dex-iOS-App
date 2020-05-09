//
//  LevelTableViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/3/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

protocol LevelTableViewDelegate {
  func selectedLevel(_ level: Int)
}

class LevelTableViewController: UITableViewController {
  
  var selectedLevel: Int!
  var delegate: LevelTableViewDelegate?
  
  let levels = [1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
  
  override func viewDidLoad() {
    title = "Select Level"
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return levels.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    if selectedLevel == levels[indexPath.row] {
      cell.accessoryType = .checkmark
    }
    cell.textLabel?.text = "\(levels[indexPath.row])"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.selectedLevel(levels[indexPath.row])
    dismiss(animated: true)
  }
  
  
}
