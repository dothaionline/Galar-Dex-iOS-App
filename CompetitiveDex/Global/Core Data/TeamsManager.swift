//
//  TeamManager.swift
//  CompetitiveDex
//
//  Created by Thai Do on 06/10/20.
//  Copyright © 2019 Thai Do. All rights reserved.
//

import CoreData
import Foundation
import UIKit

/// This class contains the CRUD methods for storing courses into Core Data
class TeamsManager {
  
  private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
  public static var teams = [NSManagedObject]()
  
  // MARK: - Getter Functionality
  static func getPokemons(for team: NSManagedObject) -> [CompetitivePokemon] {
      let pokemonsData = team.value(forKey: "pokemons") as! Data
      do {
          return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(pokemonsData) as! [CompetitivePokemon]
      } catch {
          fatalError("Unable to unarchive data as type [CompetitivePokemon]")
      }
  }
  
  static func getName(for team: NSManagedObject) -> String {
      return team.value(forKey: "name") as! String
  }
  
  // MARK: - Core Data Management
  
  /// Load courses from core data
  static func loadTeams() {
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Team")
    do {
      self.teams = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  /// Save a team into core data
  static func saveNewTeam(withName name: String, completion: (() -> ())? = nil) {
    let managedContext = self.appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Team", in: managedContext)!
    let team = NSManagedObject(entity: entity, insertInto: managedContext)
    let pokemons: [CompetitivePokemon] = []
    // Set the default values when saving the course
    do {
      let archivedPokemons = try NSKeyedArchiver.archivedData(withRootObject: pokemons, requiringSecureCoding: false)
      team.setValue(archivedPokemons, forKey: "pokemons")
      team.setValue(name, forKey: "name")
    } catch let error {
      print("Failed to archive pokemons with error: \(error)")
      fatalError("Failed to archive pokemons with error: \(error)")
    }
    
    // Save the course into Core Data
    do {
      try managedContext.save()
      self.teams.append(team)
      if let completion = completion {
        completion()
      }
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  /// Update a team with a new pokemon
  static func updateTeam(_ team: NSManagedObject, withPokemon pokemon: CompetitivePokemon) {
    let managedContext = appDelegate.persistentContainer.viewContext
    var currentTeam = self.getPokemons(for: team)
    currentTeam.append(pokemon)
    do {
      let archivedPokemons = try NSKeyedArchiver.archivedData(withRootObject: currentTeam, requiringSecureCoding: false)
      team.setValue(archivedPokemons, forKey: "pokemons")
    } catch {
      fatalError("Failed to archive pokemons")
    }

    // Save the team into Core Data
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  /// Update a team's name
  static func updateTeam(_ team: NSManagedObject, withName name: String) {
    let managedContext = appDelegate.persistentContainer.viewContext
    team.setValue(name, forKey: "name")
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  /// Delete a given course from core data.  After deleting a course, remember to remove it from the current array as well.
  static func deleteTeam(_ course: NSManagedObject, index: Int) {
    let managedContext = self.appDelegate.persistentContainer.viewContext
    managedContext.delete(course)
    do {
      try managedContext.save()
    } catch {
      fatalError("Failed to update context after deleting")
    }
    self.teams.remove(at: index)
  }

  
}
