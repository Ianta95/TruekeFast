//
//  Enums.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 12/01/21.
//

import Foundation


enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

enum UserStatus: Int {
    case NO_EXIST = 0
    case REGISTER_DATA = 1
    case ACTIVE = 2
    case SUSPENDED = 3
    case OBSERVATION = 4
    case DELETED = 5
}

enum UserType: Int {
    case NO_USER = 0
    case USER = 1
    case VERIFIER = 2
    case MEDIATOR = 3
    case APROVERS = 4
    case ASISTANCE = 5
    case DEVELOPERS = 6
    case ADMIN = 7
    case SUPERDADMIN = 8
}

enum ArticleStatus: Int {
    case NO_ARTICLE = 0
    case REGISTER_PROCESS = 1
    case ACTIVE = 3
    case SUSPENDED = 4
    case OBSERVATION = 5
    case DELETED = 6
}

enum AuthScreenStatus: Int {
    case LOGIN_EMAIL = 0
    case REGISTER_USER = 1
}
