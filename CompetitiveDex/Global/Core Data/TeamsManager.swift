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
  
  /// Save a course into core data
  static func saveNewTeam(pokemons: [CompetitivePokemon], completion: (() -> ())? = nil) {
    let managedContext = self.appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Team", in: managedContext)!
    let team = NSManagedObject(entity: entity, insertInto: managedContext)
    
    // Set the default values when saving the course
    do {
      let archivedPokemons = try NSKeyedArchiver.archivedData(withRootObject: pokemons, requiringSecureCoding: false)
      team.setValue(archivedPokemons, forKey: "pokemons")
      team.setValue("Red's Team", forKey: "name")
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
  
//  /// Delete a given course from core data.  After deleting a course, remember to remove it from the current array as well.
//  static func deleteCourse(_ course: NSManagedObject, index: Int) {
//    let managedContext = self.appDelegate.persistentContainer.viewContext
//    managedContext.delete(course)
//    do {
//      try managedContext.save()
//    } catch {
//      fatalError("Failed to update context after deleting")
//    }
//    self.courses.remove(at: index)
//  }
//
//  /// Update course with edited todo list
//  static func updateCourse(_ course: NSManagedObject, withList todos: [Todo]) {
//    let managedContext = appDelegate.persistentContainer.viewContext
//    do {
//      let archiveTodos = try NSKeyedArchiver.archivedData(withRootObject: todos, requiringSecureCoding: false)
//      course.setValue(archiveTodos, forKey: "todos")
//    } catch {
//      fatalError("Failed to archive todos")
//    }
//
//    // Save the course into Core Data
//    do {
//      try managedContext.save()
//    } catch let error as NSError {
//      print("Could not save. \(error), \(error.userInfo)")
//    }
//  }
//
//  static func updateCourse(_ course: NSManagedObject, withDays days: [Int: Bool]) {
//    let managedContext = appDelegate.persistentContainer.viewContext
//    do {
//      let archivedDays = try NSKeyedArchiver.archivedData(withRootObject: days, requiringSecureCoding: false)
//      course.setValue(archivedDays, forKey: "days")
//    } catch {
//      fatalError("Failed to archive days")
//    }
//
//    // Save the course into Core Data
//    do {
//      try managedContext.save()
//    } catch let error as NSError {
//      print("Could not save. \(error), \(error.userInfo)")
//    }
//  }
  
}
