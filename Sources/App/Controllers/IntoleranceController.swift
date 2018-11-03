//
//  IntoleranceController.swift
//  App
//
//  Created by Alexandru Turcanu on 03/11/2018.
//

import Vapor

final class IntoleranceController {
    
    func create(_ req: Request) throws -> Future<Intolerance> {
        
        //init an IntoleranceForm object from the given json
        return try req.content
            .decode(Intolerance.IntoleranceForm.self)
            .flatMap({ (intoleranceForm) in
                
                //init a User object corresponding to the userID of the intolerance
                return User
                    .find(intoleranceForm.userID, on: req)
                    .flatMap({ (user) in
                        
                        //unwrap userID
                        guard let userID = try user?.requireID() else {
                            throw Abort(.badRequest)
                        }
                        
                        //init an Intolerance
                        let intolerance = Intolerance(intoleranceForm: intoleranceForm)
                        
                        //use Future<Response>
                        //update the SQL Table with the new intolerance and refresh the User list
                        //                        return intolerance.save(on: req).map({ (_) in
                        //                            return req.redirect(to: "/users")
                        //                        })
                        
                        //just return the json of the intolerance
                        return intolerance.save(on: req)
                    })
            })
    }
}

