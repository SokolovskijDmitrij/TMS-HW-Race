//
//  UserModal.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 13.06.22.
//

import Foundation
import UIKit

enum HindranceType: String {
    case repair
    case brick
    case cone
}

struct UserModel {
    let userName: String
    let carColor: String
    let speed: Int
    let hindrance: HindranceType
}

