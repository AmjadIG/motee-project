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
    
    //Get All : https://mootee-api.herokuapp.com/tags/ => Fonctionne plus pour l'instant
    //Get by id : https://mootee-api.herokuapp.com/tags/bestTags
    
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
    
    static func getTagById(idTag : String)->Tag!{
        return getAll()[idTag]
    }
}
