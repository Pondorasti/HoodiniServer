//
//  Intolerance.swift
//  App
//
//  Created by Alexandru Turcanu on 03/11/2018.
//

import FluentSQLite
import Vapor

final class Intolerance: SQLiteModel {
    var id: Int?
    var name: String
    var userID: User.ID
    
    init(id: Int? = nil, name: String, userID: User.ID) {
        self.id = id
        self.name = name
        self.userID = userID
    }
    
    init(id: Int? = nil, intoleranceForm: IntoleranceForm) {
        self.id = id
        self.name = intoleranceForm.name
        self.userID = intoleranceForm.userID
    }
    
    struct IntoleranceForm: Content {
        var name: String
        var userID: Int
    }
}

extension Intolerance {
    var user: Parent<Intolerance, User> {
        return parent(\.userID)
    }
}

extension Intolerance {
    var tags: Siblings<Intolerance, Recipe, RecipeIntolerance> {
        return siblings()
    }
}

extension Intolerance: Content { }
extension Intolerance: Migration { }
extension Intolerance: Parameter { }

