//
//  UserController.swift
//  App
//
//  Created by Alexandru Turcanu on 03/11/2018.
//

import Vapor

final class UserController {
    
    func list(_ req: Request) throws -> Future<[User]> {
        let answer = User.query(on: req).all()
        
        //shitty way to acces the relationship
        User.query(on: req).all().map { (users) in
            let user = users.first
            try user?.intolerances.query(on: req).all().map({ (intolerances) in
                print(intolerances)
            })
        }
        
        return answer
    }
    
    //done
    func create(_ req: Request) throws -> Future<User> {
        
        return try req.content.decode(User.self).flatMap { user in
            user.creationDate = Date()
            return user.save(on: req)
        }
    }
    
    func update(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self).flatMap { user in
            return try req.content.decode(User.self).flatMap { newUser in
                user.username = newUser.username
                return user.save(on: req)
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
            }.transform(to: .ok)
    }
    
    func intolerances(_ req: Request) throws -> Future<[Intolerance]> {
        return try req.parameters.next(User.self).flatMap { user in
            return try user.intolerances.query(on: req).all()
        }
    }
}
