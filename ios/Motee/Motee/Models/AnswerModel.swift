//
//  TagModel.swift
//  Motee
//
//  Created by Amjad Menouer on 23/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI
import Foundation

class AnswerModel {
    
    //Model for Answer :
    
    //Get All : https://mootee-api.herokuapp.com/answers => 200
    //Get by id : https://mootee-api.herokuapp.com/answers/id => 200
    //Post : https://mootee-api.herokuapp.com/answers/newAnswer => 200
    //Delete(=>Post) : https://mootee-api.herokuapp.com/answers/delete => 500
    //Put : https://mootee-api.herokuapp.com/answers/like => 200
    //Put : https://mootee-api.herokuapp.com/answers/dislike => 200
    //Put : https://mootee-api.herokuapp.com/answers/update => Pas encore testé

    static func getAll()->[Answer]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/answers"
        let url = URL(string: stringURL)
        print("in getAll Answers")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:Answer] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([String:Answer].self, from: data)
                    print("decoder ok!")
                }catch let error {
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        
        return (purifyRequest(dictionary: res) as! [Answer])
    }
    
    static func getAnswerById(idAns : String)->Answer?{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/answers/\(idAns)"
        let url = URL(string: stringURL)
        print("in getAnsById")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("request ok")
        // Perform HTTP Request
        var res : [String:Answer] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    print("avant le try JSONDecoder")
                    res = try JSONDecoder().decode([String:Answer].self, from: data)
                    print(res)
                    print("decoder ok!")
                }catch let error {
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        
        return (purifyRequest(dictionary: res).first as? Answer)
    }
    
    static func getPropOfAnswer(answer : Answer)->Proposition{
        return PropositionModel.getPropositionById(idProp: answer.idProposition)
    }
    
    static func getAllTags(answer:Answer)->[Tag]{
        return PropositionModel.getAllTags(proposition: getPropOfAnswer(answer : answer))
    }
    
    static func addAnswer (contentPub: String, isAnonymous: Bool, tagsAns: [Tag], idProposition : String, token: String) -> Bool{
        // Prepare URL
        let stringurl = "https://mootee-api.herokuapp.com/answers"
        let url = URL(string: stringurl)//ICI
        
        let tagsAnswer : String = paramTagsToLabel(tags: tagsAns)
        let body = [
            "contentAnswer" : contentPub,
            "isAnonymous" : "\(isAnonymous)",
            "tagsAnswer" : tagsAnswer,
            "idProp" : idProposition
        ]
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
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

    //Données : un id de réponse (String) et un token pour l'autorisation (String)
    //Résultat : renvoie true si la réponse a été supprimée, false sinon
    static func deleteAnswer(idAns: String, token: String)->Bool{
        // Prepare URL
        let stringurl = "https://mootee-api.herokuapp.com/answers"
        let url = URL(string: stringurl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
        var res : Bool = true
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let body = [
            "id": idAns
        ]
        
        // Set HTTP Request Body
        guard let requestBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return false}
        request.httpBody = requestBody
        request.setValue(getFullToken(token: token), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("body ok + auth ok")
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
    
    //Données : un url (String), un id de réponse (String) et un token pour l'autorisation (String)
    //Résultat : renvoie true si la requête a bien été effectuée, false sinon
    static func answerLD(url : String, idAnswer : String, token : String)->Bool{
        // Prepare URL
        
        let stringurl = url
        let url = URL(string: stringurl)//ICI
        
        let body = [
            "_id" : idAnswer
        ]
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        let semaphore = DispatchSemaphore(value :0)
        var res : Bool = false
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
    
    //Données : un id de proposition (String) et un token pour l'autorisation (String)
    //Résultat : renvoie true si la proposition a bien été likée, false sinon
    static func likeAns(idAnswer : String, token : String)->Bool{
        print("propos liké")
        return answerLD(url: "https://mootee-api.herokuapp.com/answers/like", idAnswer: idAnswer, token: token)
    }
    
    //Données : un id de proposition (String) et un token pour l'autorisation (String)
    //Résultat : renvoie true si la proposition a bien été dislikée, false sinon
    static func dislikeAns(idAnswer : String, token : String)->Bool{
        print("propos disliké")
        return answerLD(url: "https://mootee-api.herokuapp.com/answers/dislike", idAnswer: idAnswer, token: token)
    }
    
    //Résultat : renvoie true si la proposition a bien été modifiée (requête envoyée et validée), false sinon
    static func updateAns(idAns : String, contentAns : String, isAnonymous : Bool, idUser : String, token : String)->Bool {
        // Prepare URL
        //guard let token = currentUser?.authToken else{return false}
        
        let stringurl = "https://mootee-api.herokuapp.com/answers/update"
        let url = URL(string: stringurl)//ICI
        
        let body = [
            "_id" : idAns,
            "contentAnswer" : contentAns,
            "isAnonymous" : "\(isAnonymous)",
            "ownerAnswer" : idUser
        ]
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        let semaphore = DispatchSemaphore(value :0)
        var res : Bool = false
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
