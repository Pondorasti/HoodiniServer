//
//  User.swift
//  App
//
//  Created by Alexandru Turcanu on 03/11/2018.
//

import FluentSQLite
import Vapor

final class User: SQLiteModel {
    var id: Int?
    var username: String
    
    init(id: Int? = nil, username: String) {
        self.id = id
        self.username = username
    }
}

extension User {
    var intolerances: Children<User, Intolerance> {
        return children(\.userID)
    }
}

extension User: Content {}
extension User: Migration {}
extension User: Parameter {}

