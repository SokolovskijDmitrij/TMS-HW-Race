////
////  SaveUserSetting.swift
////  Homework 13
////
////  Created by Дмитрий Соколовский on 13.06.22.
////
//
//import Foundation
//
//enum SaveKeys: String {
//    case userName, carColor, hindrance, speed
//}
//
//class SaveUserSettings {
//    private let defaults = UserDefaults.standard
//    
//    public static var shared = SaveUserSettings()
//    
//    var userName: String? {
//        get {
//            return defaults.string(forKey: SaveKeys.userName.rawValue)
//        }
//        set {
//            defaults.setValue(newValue, forKey: SaveKeys.userName.rawValue)
//        }
//    }
//    
//    var speed: String {
//        get {
//            guard let value = defaults.string(forKey: SaveKeys.speed.rawValue)
//            else {return ""}
//            return value
//        }
//        set {
//            defaults.setValue(newValue, forKey: SaveKeys.speed.rawValue)
//        }
//    }
//    
//    var carColor: String {
//        get {
//            guard let value = defaults.string(forKey: SaveKeys.carColor.rawValue)
//            else {return ""}
//            return value
//        }
//        set {
//            defaults.setValue(newValue, forKey: SaveKeys.carColor.rawValue)
//        }
//    }
//    
//    var hindrance: String {
//        get {
//            guard let value = defaults.string(forKey: SaveKeys.hindrance.rawValue)
//            else {return ""}
//            return value
//        }
//        set {
//            defaults.setValue(newValue, forKey: SaveKeys.hindrance.rawValue)
//        }
//    }
//    
//    private init() {}
//}
