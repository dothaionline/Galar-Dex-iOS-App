//
//  NatureTableViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/2/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

protocol ValueViewDelegate {
  func selectedIVs(_ ivs: [Stats: Int])
  func selectedEVs(_ evs: [Stats: Int])
}

enum ValueState {
  case Individual
  case Effort
}

class ValueViewController: UITableViewController, UITextFieldDelegate {
  
  var state: ValueState!
  var values: [Stats: Int]!
  var textFields: [UITextField] = []
  var delegate: ValueViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    tableView.register(ValueCell.self, forCellReuseIdentifier: ValueCell.reuseIdentifier)
  }
  
  private func setupNavigationBar() {
    title = state == .Individual ? "Set Individual Values" : "Set Effort Values"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
  }
  
  @objc func doneButtonTapped() {
    for (index, textField) in textFields.enumerated() {
      guard let stat = Stats(rawValue: index) else {
        fatalError("Unable to instantiate Stats object with rawValue: \(index)")
      }
      
      if let newValue = textField.text, !newValue.isEmpty {
        values[stat] = Int(newValue)
      }
      
    }
    
    if state == .Individual {
      delegate?.selectedIVs(values)
    } else {
      delegate?.selectedEVs(values)
    }
    
    dismiss(animated: true)
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ValueCell.reuseIdentifier) as? ValueCell else {
      fatalError("Unable to dequeue cell with identifier: \(ValueCell.reuseIdentifier)")
    }
    let currentIV = String(values[Stats.allCases[indexPath.row]]!)
    cell.configure(withDelegate: self, value: currentIV)
    textFields.append(cell.inputField)
    cell.textLabel?.text = Stats.allCases[indexPath.row].getString()
    return cell
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Stats.allCases.count
  }
  
}
