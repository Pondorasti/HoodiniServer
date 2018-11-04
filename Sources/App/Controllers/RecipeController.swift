//
//  RecipeController.swift
//  App
//
//  Created by Alexandru Turcanu on 04/11/2018.
//

import Vapor

final class RecipeController {
    
    func list(_ req: Request) throws -> Future<[Recipe]> {
        let answer = Recipe.query(on: req).all()
        
        return answer
    }
    
    func create(_ req: Request) throws -> Future<Recipe> {
        return try req.content.decode(Recipe.self).flatMap { recipe in
            return recipe.save(on: req)
        }
    }
    
}

