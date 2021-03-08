//
//  KingController.swift
//  ChilisGauntlet
//
//  Created by Benjamin Tincher on 3/8/21.
//

import Foundation

struct RiverConstants {
    static var name = "River"
    static var age = "26"
    static var hometown = "Oakland, CA"
    static var previousJob = "TEST"
    static var dreamJob = "TEST"
    static var chilisJam = "TEST"
    static var bio = "TEST"
}

struct ChristianConstants {
    static var name = "Christian"
    static var age = "25"
    static var hometown = ""
    static var previousJob = ""
    static var dreamJob = ""
    static var chilisJam = ""
    static var bio = ""
}

struct BenConstants {
    static var name = "Ben"
    static var age = "34"
    static var hometown = ""
    static var previousJob = ""
    static var dreamJob = ""
    static var chilisJam = ""
    static var bio = ""
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
    func updateKingWith(king: King, name: String?, age: String?, hometown: String?, previousJob: String?, dreamJob: String?, chilisJam: String?, bio: String?) {
        
    }
    
    
    // MARK: - Data Persistence
    // fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("ChilisGauntlet.json")
        return fileURL
    }
    
    //save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(kings)
            try data.write(to: fileURL())
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
            return true
        } catch {
            print(error)
            print(error.localizedDescription)
            return false
        }
    }
}
