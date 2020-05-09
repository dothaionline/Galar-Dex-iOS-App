//
//  NatureTableViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/2/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

protocol NatureTableViewControllerDelegate {
  func selectedNature(_ nature: Nature)
}

class NatureTableViewController: UITableViewController {
  
  var selectedNature: Nature?
  var delegate: NatureTableViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Set Nature"
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    if let selectedNature = selectedNature {
      if Nature.allCases[indexPath.row] == selectedNature {
        cell.accessoryType = .checkmark
      }
    }
    let nature = Nature.allCases[indexPath.row]
    let affectedStats = nature.getStatBenefits()
    var stats = ""
    if let benefitStat = affectedStats.0,
      let hinderingStat = affectedStats.1 {
      stats = "(+\(benefitStat.getString()), -\(hinderingStat.getString()))"
    }
    cell.textLabel?.text = nature.rawValue + " " + stats
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.selectedNature(Nature.allCases[indexPath.row])
    dismiss(animated: true)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Nature.allCases.count
  }
  
}
