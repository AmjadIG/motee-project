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
    //register : https://mootee-api.herokuapp.com/users/ => 200
    //ban a user : https://mootee-api.herokuapp.com/users/admin/ban => ?
    
    static func getAll()->[User]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/users"
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
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
                }catch let error {
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        print("Get All Users ... done")
        return (purifyRequest(dictionary: res) as! [User])
    }
    
    static func getUserById(idUser : String)->User{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/users/"+idUser
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
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
                }catch let error {
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        print("Get User[\(idUser)] ... done")
        return purifyRequest(dictionary: res)[0] as! User
    }
    
    static func getAnswersByUser(user : User)->[Answer]{
        var answerArray : [Answer] = []
        for ans in AnswerModel.getAll() {
            if ans.owner == user.idUser {
                answerArray.append(ans)
            }
        }
        print("Get Answers of User[\(user.pseudo)] ... done")
        return answerArray
    }
    
    static func getAnswersByUserId(idUser : String)->[Answer]{
        print("Get Answers of User[\(idUser)] ... done")
        return getAnswersByUser(user: getUserById(idUser: idUser))
    }
    
    static func getPropsByUser(user : User)->[Proposition]{
        var propositionArray : [Proposition] = []
        for prop in PropositionModel.getAll() {
            if prop.owner == user.idUser {
                propositionArray.append(prop)
            }
        }
        print("Get Propositions of User[\(user.pseudo)] ... done")
        return propositionArray
    }
    
    static func getPropsByUserId(idUser : String)->[Proposition]{
        print("Get Propositions of User[\(idUser)] ... done")
        return getPropsByUser(user: getUserById(idUser: idUser))
    }
    
    static func getUserByPseudo(pseudo : String)->User?{
        for user in getAll(){
            if user.pseudo == pseudo {
                print("Get User[\(pseudo)] ... done")
                return user
            }
        }
        return nil
    }
    
    static func authenticate(pseudo : String, password : String)->String{
        // Prepare URL
        
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
        
        var res : String = ""
        // Perform HTTP Request
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            } else {
                let resp = response as? HTTPURLResponse
                if (resp?.statusCode == 200) {
                    if let data = data{
                        print(data)
                        if let token = String(data: data, encoding: .utf8){
                            res = token
                            print(token)
                        }
                    }
                }
            }
                
            
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        print("Authentication['\(pseudo)','you will never get this password :D'] ... done")
        return res
    }
    
    static func checkAuthenticate(pseudo : String, password : String)->[Any]{
        let token = authenticate(pseudo: pseudo, password: password)
        if token != "" {
            print("Checking authentication => OK ... done")
            return [token, getUserByPseudo(pseudo: pseudo)!]
        } else {
            print("Checking authentication => WRONG PSEUDO/PASSWORD ... done")
            return []
        }
    }
    
    static func register(pseudo: String, password: String, mail: String)->Bool{
        // Prepare URL
        
        let stringurl = "https://mootee-api.herokuapp.com/users"
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
        //print("json : " , String(data : request.httpBody!, encoding: .utf8)!)
        
        var res : Bool = false
        // Perform HTTP Request
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            let resp = response as? HTTPURLResponse
            res = (resp?.statusCode == 200)
                        
            if let data = data{
                if let jsonString = String(data: data, encoding: .utf8){
                    print("Registering new User['\(pseudo)','...','\(mail)] => \(jsonString) ... done")
                    }
                }
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
        return res
    }
    
    static func banUser(idUser : String, token : String)->Bool{
        // Prepare URL
        
        let stringurl = "https://mootee-api.herokuapp.com/users/admin/ban"
        let url = URL(string: stringurl)
        
        let body = [
            "id" : idUser
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
        request.setValue(getFullToken(token: token), forHTTPHeaderField: "Authorization")
        //print("json : " , String(data : request.httpBody!, encoding: .utf8)!)
        
        var res : Bool = false
        // Perform HTTP Request
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            let resp = response as? HTTPURLResponse
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
        print("Ban the User[\(idUser)] ... done")
        return res
    }
    
    static func logout(token : String)->Bool{
        // Prepare URL
        
        let stringurl = "https://mootee-api.herokuapp.com/users/logout"
        let url = URL(string: stringurl)
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        let semaphore = DispatchSemaphore(value :0)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(getFullToken(token: token), forHTTPHeaderField: "Authorization")
        
        var res : Bool = true
        // Perform HTTP Request
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            let resp = response as? HTTPURLResponse
            res = (resp?.statusCode == 200)
                        
            if let data = data{
                if let jsonString = String(data: data, encoding: .utf8){
                    print("Log out => \(jsonString) ... done")
                    }
                }
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
        return res
    }
    
    static func updateUser(oldPwd: String, newPwd:String, confirmPwd: String, token : String)->Bool {
        // Prepare URL
        
        let stringurl = "https://mootee-api.herokuapp.com/users/password/change"
        let url = URL(string: stringurl)//ICI
        
        let body = [
            "oldPassword" : oldPwd,
            "newPassword" : newPwd,
            "confirmPassword" : confirmPwd
        ]
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        let semaphore = DispatchSemaphore(value :0)
        var res : Bool = true
        // Set HTTP Request Body
        guard let requestBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return false}
        
        request.httpBody = requestBody
        request.setValue(getFullToken(token: token), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("json : " , String(data : request.httpBody!, encoding: .utf8)!)
        // Perform HTTP Request
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
                
                let resp = response as? HTTPURLResponse
                res = (resp?.statusCode == 200)
            if let data = data{
                if let jsonString = String(data: data, encoding: .utf8){
                    print("Update the User['whith token in body'] => \(jsonString) ... done")
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return res
    }
}
