//
//  PropositionModel.swift
//  Motee
//
//  Created by Amjad Menouer on 23/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI
import Foundation

class PropositionModel {
    
    //Model for Proposition :

    //Get All : https://mootee-api.herokuapp.com/propositions
    //Get by id : https://mootee-api.herokuapp.com/propositions/id
    //Post : https://mootee-api.herokuapp.com/propositions/newProposition => Pas encore testé
    //Delete : https://mootee-api.herokuapp.com/propositions/delete => Pas encore testé

     static func getAll()->[String:Proposition]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/propositions"
        let url = URL(string: stringURL)
        print("in getAll")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:Proposition] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([String:Proposition].self, from: data)
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
    
    static func getAllProps()->[Proposition]{
        return (purifyRequest(dictionary: getAll()) as! [Proposition])
    }
    
    static func getPropositionById(idProp : String)->Proposition{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/propositions/"+idProp
        let url = URL(string: stringURL)
        print("in get by id")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:Proposition] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([String:Proposition].self, from: data)
                    print("decoder ok!")
                }catch let error {
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        
        return (purifyRequest(dictionary: res)[0] as! Proposition)
    }
    
    static func getAllAnswer(proposition : Proposition)->[Answer]{
        var result : [Answer] = []
        for (key,value) in AnswerModel.getAll() {
            for answer in proposition.answers {
                if answer == key {
                    result.append(value)
                }
            }
        }
        return result
    }
    
    static func getBestAnswer(proposition : Proposition)->Answer?{
        let answerArray = getAllAnswer(proposition: proposition)
        if answerArray.count == 0 {
            return nil
        } else {
            var bestAnswer = answerArray[0]
            for answer in answerArray {
                if answer.idLikesAnswer.count > bestAnswer.idLikesAnswer.count {
                    bestAnswer = answer
                }
            }
            return bestAnswer
        }
    }
    
    static func getAllTags(proposition:Proposition)->[Tag]{
        var tagArray : [Tag] = []
        for tag in proposition.tags {
            tagArray.append((TagModel.getTagById(idTag: tag)))
        }
        return tagArray
    }
    
    static func getFilteredProps(filter: String, tags : [Tag])->[Proposition]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/propositions/sort/"+filter+paramTags(tags: tags)
        let url = URL(string: stringURL)
        print(stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [Proposition] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([Proposition].self, from: data)
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
    
    static func addProposition(contentPub: String, isAnonymous: Bool, tagsProp: [Tag], token: String) -> Bool{
        // Prepare URL
        //guard let token = currentUser?.authToken else{return false}
        
        let stringurl = "https://mootee-api.herokuapp.com/propositions/newProposition"
        let url = URL(string: stringurl)//ICI
        
        let tagsProp : String = paramTagsToLabel(tags: tagsProp)
        let body = [
            "contentProp" : contentPub,
            "isAnonymous" : "\(isAnonymous)",
            "tagsProp" : tagsProp
        ]
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let semaphore = DispatchSemaphore(value :0)
        var res : Bool = false
        // Set HTTP Request Body
        guard let requestBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return false}
        
        request.httpBody = requestBody
        request.setValue(token, forHTTPHeaderField: "Bearer Token")
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
    
    static func deleteProposition(idProp: String, token: String)->Bool{
        // Prepare URL
        //guard let token = currentUser?.authToken else{return false}
        let stringurl = "https://mootee-api.herokuapp.com/propositions/delete"
        let url = URL(string: stringurl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
        var res : Bool = false
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let body = [
            "id_proposition": idProp
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
