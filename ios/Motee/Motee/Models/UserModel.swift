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
    //register : https://mootee-api.herokuapp.com/users/register => 200
    //ban a user : https://mootee-api.herokuapp.com/users/admin/ban => ?
    
    static func getAll()->[User]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/users"
        let url = URL(string: stringURL)
        print("in getAll Users")
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
        
        return (purifyRequest(dictionary: res) as! [User])
    }
    
    static func getUserById(idUser : String)->User{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/users/"+idUser
        let url = URL(string: stringURL)
        print("in get User by id")
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
        for ans in AnswerModel.getAll() {
            if ans.owner == user.idUser {
                answerArray.append(ans)
            }
        }
        return answerArray
    }
    
    static func getAnswersByUserId(idUser : String)->[Answer]{
        return getAnswersByUser(user: getUserById(idUser: idUser))
    }
    
    static func getPropsByUser(user : User)->[Proposition]{
        var propositionArray : [Proposition] = []
        for prop in PropositionModel.getAll() {
            if prop.owner == user.idUser {
                propositionArray.append(prop)
            }
        }
        
        return propositionArray
    }
    
    static func getPropsByUserId(idUser : String)->[Proposition]{
        return getPropsByUser(user: getUserById(idUser: idUser))
    }
    
    static func getUserByPseudo(pseudo : String)->User?{
        for user in getAll(){
            if user.pseudo == pseudo {
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
        print("json : " , String(data : request.httpBody!, encoding: .utf8)!)
        
        var res : String = ""
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
        return res
    }
    
    static func checkAuthenticate(pseudo : String, password : String)->[Any]{
        let token = authenticate(pseudo: pseudo, password: password)
        if token != "" {
            print([token, getUserByPseudo(pseudo: pseudo)!])
            return [token, getUserByPseudo(pseudo: pseudo)!]
        } else {
            return []
        }
    }
    
    static func register(pseudo: String, password: String, mail: String)->Bool{
        // Prepare URL
        
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
    
    static func logout(token : String)->Bool{
        // Prepare URL
        
        let stringurl = "https://mootee-api.herokuapp.com/users/logout"
        let url = URL(string: stringurl)
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        let semaphore = DispatchSemaphore(value :0)
        print(getFullToken(token: token))
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
            print("code d'erreur")
                res = (resp?.statusCode == 200)
                print(res)
            if let data = data{
                print(data)
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
