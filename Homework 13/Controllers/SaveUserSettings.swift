//
//  SaveUserSetting.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 13.06.22.
//

import Foundation
import UIKit

enum SaveKeys: String {
    case userName, carColor, hindrance, speed, userImage, scores
}

class SaveUserSettings {
    private let defaults = UserDefaults.standard
    
    public static var shared = SaveUserSettings()
    var usersScores: [RecordGame] {
        get {
            guard let dataArray = defaults.array(forKey: SaveKeys.scores.rawValue) as? [Data] else {
                return []
            }
            let scores: [RecordGame]
            do {
                scores = try dataArray.map { try PropertyListDecoder().decode(RecordGame.self, from: $0) }
            } catch {
                scores = []
            }
            return scores }
        set {
            let dataArray = newValue.map { try? PropertyListEncoder().encode($0) }
            defaults.setValue(dataArray, forKey: SaveKeys.scores.rawValue)
        }
    }
    
    func record(recordGame: RecordGame) {
     usersScores = usersScores + [recordGame]
    }
    
    
    var userName: String? {
        get {
            return defaults.string(forKey: SaveKeys.userName.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: SaveKeys.userName.rawValue)
        }
    }
    
    var speed: String {
        get {
            guard let value = defaults.string(forKey: SaveKeys.speed.rawValue)
            else {return ""}
            return value
        }
        set {
            defaults.setValue(newValue, forKey: SaveKeys.speed.rawValue)
        }
    }
    
    var carColor: String {
        get {
            guard let value = defaults.string(forKey: SaveKeys.carColor.rawValue) else {
                return "" }
            return value
        }
        set {
            defaults.setValue(newValue, forKey: SaveKeys.carColor.rawValue)
        }
    }
    
    var hindrance: String {
        get {
            guard let value = defaults.string(forKey: SaveKeys.hindrance.rawValue) else {
                return "" }
            return value
        }
        set {
            defaults.setValue(newValue, forKey: SaveKeys.hindrance.rawValue)
        }
    }
    
    private init() {}
}




