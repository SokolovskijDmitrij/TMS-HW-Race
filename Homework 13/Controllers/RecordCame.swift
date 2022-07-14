//
//  RecordCame.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 7.07.22.
//

import Foundation
import UIKit

struct RecordGame: Codable, Comparable {
    static func < (lhs: RecordGame, rhs: RecordGame) -> Bool {
        lhs.userScore < rhs.userScore
    }
    var userName: String
    var userScore: Int
    var date: Date
    var stringDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self.date)
    }
}
