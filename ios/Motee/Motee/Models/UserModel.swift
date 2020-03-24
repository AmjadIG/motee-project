//
//  UserModel.swift
//  Motee
//
//  Created by Amjad Menouer on 23/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI
import Foundation

class UserModel {
    
    //Model for User :
    
    //Get All : https://mootee-api.herokuapp.com/users
    //Get by id : https://mootee-api.herokuapp.com/users/id
    
    static func getAll()->[String:User]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/users"
        let url = URL(string: stringURL)
        print("in getAll")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:User] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([String:User].self, from: data)
                    print("decoder ok!")
                }catch let error {
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        
        return res
    }
    
    static func getUserById(idUser : String)->User{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/users/"+idUser
        let url = URL(string: stringURL)
        print("in getAll")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:User] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([String:User].self, from: data)
                    print("decoder ok!")
                }catch let error {
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return purifyRequest(dictionary: res)[0] as! User
    }
    
    static func getPropositionsByUser(user : User)->[Proposition]{
        var propositionArray : [Proposition] = []
        for idProp in user.idPropositions {
            for prop in PropositionModel.getAllProps() {
                if prop.id == idProp {
                    propositionArray.append(prop)
                }
            }
        }
        return propositionArray
    }
    
    static func getAnswersByUser(user : User)->[Answer]{
        var answerArray : [Answer] = []
        for idAns in user.idAnswers {
            answerArray.append(purifyRequest(dictionary: AnswerModel.getAnswerById(idAns: idAns))[0] as! Answer)
        }
        return answerArray
    }
}
