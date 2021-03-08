//
//  KingController.swift
//  ChilisGauntlet
//
//  Created by Benjamin Tincher on 3/8/21.
//

import Foundation

struct RiverConstants {
    static var name = "River McCaine"
    static var age = "26"
    static var hometown = "Oakland, CA"
    static var previousJob = "Server at Sushi Restauraunt"
    static var dreamJob = "Diesel Power Specialist"
    static var chilisJam = "Texas Dry Rub"
    static var bio = "Honorary member of the Wu Tang Clan"
    static let imageString = "RiverImage"
}

struct ChristianConstants {
    static var name = "Christian Johnson"
    static var age = "25"
    static var hometown = "Las Vegas, NV"
    static var previousJob = "Finance"
    static var dreamJob = "iOS Developer & Photographer"
    static var chilisJam = "3 for 10, Bacon Cheeseburger & Cherry Coke"
    static var bio = "Like Chilis & Elon. Nothing else."
    static let imageString = "ChristianImage"
}

struct BenConstants {
    static var name = "Ben Tincher"
    static var age = "34"
    static var hometown = "Ormond Beach, FL"
    static var previousJob = "Engineer"
    static var dreamJob = "Trophy Husband"
    static var chilisJam = "Triple Tacos and Dos Equis Amber"
    static var bio = "In west Philadelphia, I was born and raised..."
    static let imageString = "BenImage"
}

// MARK: - KingController
class KingController {
    // MARK: - Shared Instance
    static let shared = KingController()
    
    // MARK: - Source of Truth
    var kings: [King] = []
    
    // MARK: - CRUD
    // Create
    func createKings() {
        kings = [
            King(name: RiverConstants.name, homeTown: RiverConstants.hometown, age: RiverConstants.age, previousJob: RiverConstants.previousJob, dreamJob: RiverConstants.dreamJob, chilisJam: RiverConstants.chilisJam, bio: RiverConstants.bio),
            
            King(name: ChristianConstants.name, homeTown: ChristianConstants.hometown, age: ChristianConstants.age, previousJob: ChristianConstants.previousJob, dreamJob: ChristianConstants.dreamJob, chilisJam: ChristianConstants.chilisJam, bio: ChristianConstants.bio),
            
            King(name: BenConstants.name, homeTown: BenConstants.hometown, age: BenConstants.age, previousJob: BenConstants.previousJob, dreamJob: BenConstants.dreamJob, chilisJam: BenConstants.chilisJam, bio: BenConstants.bio)
        ]
    }
    
    // Update
    func updateKingWith(king: King, name: String, age: String, hometown: String, previousJob: String, dreamJob: String, chilisJam: String, bio: String) {
        king.name = name
        king.age = age
        king.homeTown = hometown
        king.previousJob = previousJob
        king.dreamJob = dreamJob
        king.chilisJam = chilisJam
        king.bio = bio
        saveToPersistenceStore()
    }
    
    
    // MARK: - Data Persistence
    // fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("KingController.json")
        return fileURL
    }
    
    //save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(kings)
            try data.write(to: fileURL())
            print("saved...")
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //load
    func loadFromPersistenceStore() -> Bool {
        do {
            let data = try Data(contentsOf: fileURL())
            let foundKings = try JSONDecoder().decode([King].self, from: data)
            kings = foundKings
            print("loaded...")
            return true
        } catch {
            print(error)
            print(error.localizedDescription)
            return false
        }
    }
}
