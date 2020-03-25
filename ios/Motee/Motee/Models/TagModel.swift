//
//  TagModel.swift
//  Motee
//
//  Created by Amjad Menouer on 23/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI
import Foundation

class TagModel {
    
    //Model for Tag :
    
    //Get All : https://mootee-api.herokuapp.com/tags/ => 200
    //Get best tags : https://mootee-api.herokuapp.com/tags/bestTags => 200
    //Get by id : https://mootee-api.herokuapp.com/tags/id => 200

    static func getAll()->[String:Tag]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/tags/"
        let url = URL(string: stringURL)
        print("in getAll")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:Tag] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([String:Tag].self, from: data)
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
    
    static func getTop9Tags()->[String:Tag]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/tags/bestTags"
        let url = URL(string: stringURL)
        print("in getAll")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:Tag] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([String:Tag].self, from: data)
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
    
    static func getTagById(idTag : String)->Tag{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/tags/"+idTag
        let url = URL(string: stringURL)
        print("in get by id")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:Tag] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([String:Tag].self, from: data)
                    print("decoder ok!")
                }catch let error {
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        
        return (purifyRequest(dictionary: res)[0] as! Tag)
    }
    
    //Résultat : renvoie true si le tag a bien été détruit, false sinon
    static func deleteTag(idTag: String, token: String)->Bool{
        // Prepare URL
        //guard let token = currentUser?.authToken else{return false}
        let stringurl = "https://mootee-api.herokuapp.com/tags/delete"
        let url = URL(string: stringurl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        var res : Bool = false
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let body = [
            "id_tag": idTag
        ]
        
        // Set HTTP Request Body
        guard let requestBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return false}
        request.httpBody = requestBody
        request.setValue(token, forHTTPHeaderField: "Bearer Token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                    let resp = response as? HTTPURLResponse
                    res = (resp?.statusCode == 200)
        }
        task.resume()
        return res
    }
}
