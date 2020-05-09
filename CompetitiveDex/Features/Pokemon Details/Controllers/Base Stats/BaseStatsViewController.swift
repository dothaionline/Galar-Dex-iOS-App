//
//  BaseStatsViewController.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/2/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class BaseStatsViewController: UITableViewController {
  
  var pokemon: Pokemon!
    
  var level: Int = 50 {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  var nature: Nature = .Hardy {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  var ivs: [Stats: Int] = [.HP: 31,
                           .Attack: 31,
                           .Defense: 31,
                           .SpAtk: 31,
                           .SpDef: 31,
                           .Speed: 31] {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  var evs: [Stats: Int] = [.HP: 0,
                           .Attack: 0,
                           .Defense: 0,
                           .SpAtk: 0,
                           .SpDef: 0,
                           .Speed: 0] {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = .systemBackground
    tableView.register(StatsCell.self, forCellReuseIdentifier: StatsCell.reuseIdentifier)
    // Do any additional setup after loading the view.
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
      cell.accessoryType = .disclosureIndicator
      cell.textLabel?.text = "Level"
      cell.detailTextLabel?.text = "\(level)"
      return cell
    } else if indexPath.row == 1 {
      let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
      var stats = ""
      cell.textLabel?.text = "Nature"
      let affectedStats = nature.getStatBenefits()
      if let beneficialStat = affectedStats.0,
        let hinderingStat = affectedStats.1 {
        stats = "(+\(beneficialStat.getString()), -\(hinderingStat.getString()))"
      }
      cell.detailTextLabel?.text = nature.rawValue + " " + stats
      cell.accessoryType = .disclosureIndicator
      return cell
    } else if indexPath.row == 2 {
      let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
      let ivsDetail = "\(ivs[.HP]!)/\(ivs[.Attack]!)/\(ivs[.Defense]!)/\(ivs[.SpAtk]!)/\(ivs[.SpDef]!)/\(ivs[.Speed]!)"
      cell.detailTextLabel?.text = ivsDetail
      cell.textLabel?.text = "Individual Values"
      cell.accessoryType = .disclosureIndicator
      return cell
    } else if indexPath.row == 3 {
      let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
      let evsDetail = "\(evs[.HP]!)/\(evs[.Attack]!)/\(evs[.Defense]!)/\(evs[.SpAtk]!)/\(evs[.SpDef]!)/\(evs[.Speed]!)"
      cell.detailTextLabel?.text = evsDetail
      cell.textLabel?.text = "Effort Values"
      cell.accessoryType = .disclosureIndicator
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: StatsCell.reuseIdentifier) as? StatsCell else {
        fatalError("Unable to dequeue cell with reuse identifier: \(StatsCell.reuseIdentifier)")
      }
      guard let stat = Stats(rawValue: indexPath.row - 4) else {
        fatalError("Unable to instantiate Stats with rawValue: \(indexPath.row)")
      }
      
      guard let iv = ivs[stat] else {
        fatalError("Unable to retrieve IV for stat: \(stat)")
      }
      
      guard let ev = evs[stat] else {
        fatalError("Unable to retrieve EV for stat: \(stat)")
      }
      let baseStat = pokemon.baseStats[indexPath.row - 4]
      let calculatedStat = calculateStat(forLevel: level, nature: nature, andStat: stat, baseStat: baseStat, iv: iv, ev: ev)
      let maxStat = getMaxStats(forStat: stat, baseStat: baseStat)
      cell.configure(for: stat, baseStat: baseStat, calculatedStat: calculatedStat, maxStat: maxStat, andColor: .getColor(for: pokemon.types[0]))
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      let levelController = LevelTableViewController()
      levelController.selectedLevel = self.level
      levelController.delegate = self
      let navController = UINavigationController(rootViewController: levelController)
      present(navController, animated: true)
    } else if indexPath.row == 1 {
      let natureController = NatureTableViewController()
      natureController.selectedNature = self.nature
      natureController.delegate = self
      let navController = UINavigationController(rootViewController: natureController)
      present(navController, animated: true)
    } else if indexPath.row == 2 {
      let ivController = ValueViewController()
      ivController.state = .Individual
      ivController.delegate = self
      ivController.values = self.ivs
      let navController = UINavigationController(rootViewController: ivController)
      present(navController, animated: true)
    } else if indexPath.row == 3 {
      let evController = ValueViewController()
      evController.state = .Effort
      evController.delegate = self
      evController.values = self.evs
      let navController = UINavigationController(rootViewController: evController)
      present(navController, animated: true)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4 + Stats.allCases.count
  }
  
  private func getMaxStats(forStat stat: Stats, baseStat: Int) -> Int {
    switch stat {
    case .HP:
      return calculateStat(forLevel: 100, nature: .Adamant, andStat: stat, baseStat: baseStat, iv: 31, ev: 252)
    case .Attack:
      return calculateStat(forLevel: 100, nature: .Adamant, andStat: stat, baseStat: baseStat, iv: 31, ev: 252)
    case .Defense:
      return calculateStat(forLevel: 100, nature: .Bold, andStat: stat, baseStat: baseStat, iv: 31, ev: 252)
    case .SpAtk:
      return calculateStat(forLevel: 100, nature: .Modest, andStat: stat, baseStat: baseStat, iv: 31, ev: 252)
    case .SpDef:
      return calculateStat(forLevel: 100, nature: .Calm, andStat: stat, baseStat: baseStat, iv: 31, ev: 252)
    case .Speed:
      return calculateStat(forLevel: 100, nature: .Timid, andStat: stat, baseStat: baseStat, iv: 31, ev: 252)
    }
  }
  
  private func calculateStat(forLevel level: Int, nature: Nature, andStat stat: Stats, baseStat: Int, iv: Int, ev: Int) -> Int {
    let l = Double(level)
    let b = Double(baseStat)
    let e = Double(ev) / 4.0
    let i = Double(iv)
    var n = 1.0
    if stat == .HP {
      return Int(Double((((2 * b + i + e) * l / 100.0) + l + 10.0)).rounded(.down))
    } else if stat == .Attack {
      switch nature {
      case .Lonely, .Brave, .Adamant, .Naughty:
        n = 1.1
      case .Bold, .Modest, .Calm, .Timid:
        n = 0.9
      default:
        n = 1.0
      }
    } else if stat == .Defense {
      switch nature {
      case .Bold, .Relaxed, .Impish, .Lax:
        n = 1.1
      case .Lonely, .Mild, .Gentle,.Hasty:
        n = 0.9
      default:
        n = 1.0
      }
    } else if stat == .SpAtk {
      switch nature {
      case .Modest, .Mild, .Quiet, .Rash:
        n = 1.1
      case .Adamant, .Impish, .Careful, .Jolly:
        n = 0.9
      default:
        n = 1.0
      }
    } else if stat == .SpDef {
      switch nature {
      case .Calm, .Gentle, .Sassy, .Careful:
        n = 1.1
      case .Naughty, .Lax, .Rash, .Naive:
        n = 0.9
      default:
        n = 1.0
      }
    } else {
      switch nature {
      case .Timid, .Hasty, .Jolly, .Naive:
        n = 1.1
      case .Brave, .Relaxed, .Quiet, .Sassy:
        n = 0.9
      default:
        n = 1.0
      }
    }
    return Int(((((2 * b + i + e) * l / 100.0) + 5) * n).rounded(.down))
  }

}

extension BaseStatsViewController: NatureTableViewControllerDelegate, ValueViewDelegate, LevelTableViewDelegate {
  
  func selectedNature(_ nature: Nature) {
    self.nature = nature
  }
  
  func selectedIVs(_ ivs: [Stats : Int]) {
    self.ivs = ivs
  }
  
  func selectedEVs(_ evs: [Stats : Int]) {
    self.evs = evs
  }
  
  func selectedLevel(_ level: Int) {
    self.level = level
  }
  
}
