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
    
    //Get All : https://mootee-api.herokuapp.com/users => 200
    //Get by id : https://mootee-api.herokuapp.com/users/id => 200
    //authenticate : https://mootee-api.herokuapp.com/users/authenticate => 200
    //register : https://mootee-api.herokuapp.com/users/register
    
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
    
    static func getAnswersByUser(user : User)->[Answer]{
        var answerArray : [Answer] = []
        for idAns in user.idAnswers {
            answerArray.append(purifyRequest(dictionary: AnswerModel.getAnswerById(idAns: idAns))[0] as! Answer)
        }
        return answerArray
    }
    
    static func getAnswersByUserId(idUser : String)->[Answer]{
        return getAnswersByUser(user: getUserById(idUser: idUser))
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
    
    static func getPropsByUserId(idUser : String)->[Proposition]{
        return getPropositionsByUser(user: getUserById(idUser: idUser))
    }
    
    static func getUserByPseudo(pseudo : String)->User?{
        for(_,value) in getAll(){
            if value.pseudo == pseudo {
                return value
            }
        }
        return nil
    }
    
    static func authenticate(pseudo : String, password : String)->String{
        // Prepare URL
        //guard let token = currentUser?.authToken else{return false}
        
        let stringurl = "https://mootee-api.herokuapp.com/users/authenticate"
        let url = URL(string: stringurl)
        
        let body = [
            "pseudo" : pseudo,
            "password" : password
        ]
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let semaphore = DispatchSemaphore(value :0)
        // Set HTTP Request Body
        guard let requestBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return ""}
        
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("json : " , String(data : request.httpBody!, encoding: .utf8)!)
        
        var res : String = "Bearer "
        // Perform HTTP Request
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            } else {
                let resp = response as? HTTPURLResponse
                print("code d'erreur?")
                if (resp?.statusCode == 200) {
                    if let data = data{
                        print(data)
                        if let token = String(data: data, encoding: .utf8){
                            res += token
                            print(token)
                        }
                    }
                }
            }
                
            
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return res
    }
    
    static func checkAuthenticate(pseudo : String, password : String)->[Any]{
        let token = authenticate(pseudo: pseudo, password: password)
        if token != "" {
            return [token, getUserByPseudo(pseudo: pseudo)!]
        } else {
            return []
        }
    }
    
    static func register(pseudo: String, password: String, mail: String)->Bool{
        // Prepare URL
        //guard let token = currentUser?.authToken else{return false}
        
        let stringurl = "https://mootee-api.herokuapp.com/users/register"
        let url = URL(string: stringurl)
        
        let body = [
            "pseudo" : pseudo,
            "password" : password,
            "mail" : mail
        ]
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let semaphore = DispatchSemaphore(value :0)
        // Set HTTP Request Body
        guard let requestBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return false}
        
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("json : " , String(data : request.httpBody!, encoding: .utf8)!)
        
        var res : Bool = false
        // Perform HTTP Request
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            let resp = response as? HTTPURLResponse
            print("code d'erreur")
            res = (resp?.statusCode == 200)
                        
            if let data = data{
                if let jsonString = String(data: data, encoding: .utf8){
                    print(jsonString)
                    }
                }
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
        return res
            
        
    }
}
