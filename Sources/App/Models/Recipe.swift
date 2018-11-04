//
//  Recipe.swift
//  App
//
//  Created by Alexandru Turcanu on 04/11/2018.
//

import FluentSQLite
import Vapor

final class Recipe: SQLiteModel {
    var id: Int?
    var name: String
    var ingredients = [Ingredient]()
    
    init(id: Int? = nil, name: String, ingredients: [Ingredient]) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
    }
}

extension Recipe: Content {}
extension Recipe: Migration {}
extension Recipe: Parameter {}

//extension Recipe {
//    var tags: Siblings<Recipe, Intolerance, RecipeIntolerance> {
//        return siblings()
//    }
//}
//
//final class RecipeIntolerance: SQLitePivot {
//    typealias Left = Recipe
//    typealias Right = Intolerance
//
//    var id: Int?
//
//    static let leftIDKey: LeftIDKey = \.recipeID
//    static let rightIDKey: RightIDKey = \.intoleranceID
//
//    var recipeID: Recipe.ID
//    var intoleranceID: Intolerance.ID
//}
