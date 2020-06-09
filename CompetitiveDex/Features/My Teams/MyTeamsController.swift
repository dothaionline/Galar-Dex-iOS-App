//
//  MyTeamsController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 6/8/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class MyTeamsController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupTableView()
  }
  
  private func setupNavigationBar() {
    title = "My Teams"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
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
    return 3
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamCell.reuseIdentifier, for: indexPath) as? TeamCell else {
      fatalError()
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 170
  }
  
}
