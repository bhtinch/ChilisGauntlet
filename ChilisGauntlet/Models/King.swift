//
//  King.swift
//  ChilisGauntlet
//
//  Created by Benjamin Tincher on 3/8/21.
//
import Foundation
import UIKit

// MARK: - Model Object
class King: Codable {
    var name: String
    var homeTown: String
    var age: String
    var previousJob: String
    var dreamJob: String
    var chilisJam: String
    var bio: String
    
    init(name: String, homeTown: String, age: String, previousJob: String, dreamJob: String, chilisJam: String, bio: String) {
        self.name = name
        self.homeTown = homeTown
        self.age = age
        self.previousJob = previousJob
        self.dreamJob = dreamJob
        self.chilisJam = chilisJam
        self.bio = bio
    }
}

