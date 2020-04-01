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

    //Get All : https://mootee-api.herokuapp.com/propositions => 200
    //Get by id : https://mootee-api.herokuapp.com/propositions/id => 200
    //Post : https://mootee-api.herokuapp.com/propositions/newProposition => 200
    //Delete(=>Post) : https://mootee-api.herokuapp.com/propositions/delete => 200
    //Put : https://mootee-api.herokuapp.com/propositions/like => 200
    //Put : https://mootee-api.herokuapp.com/propositions/dislike => 200
    //Put : https://mootee-api.herokuapp.com/propositions/update => Pas encore testé
    
    //Resultat : Renvoie un dictionnaire [ clé : id des propositions | valeur : Toutes les Propositions ]
    static func getAll()->[Proposition]{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/propositions"
        let url = URL(string: stringURL)
        print("in getAll Props")
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
        
        return (purifyRequest(dictionary: res) as! [Proposition])
    }
    
    //Données : idProp (id Proposition) => String
    //Résultat : Renvoie une proposition (qui possède idProp comme id)
    static func getPropositionById(idProp : String)->Proposition{
        // Prepare URL
        let stringURL = "https://mootee-api.herokuapp.com/propositions/"+idProp
        let url = URL(string: stringURL)
        print("in get Props by id")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        print("request ok")
        // Perform HTTP Request
        var res : [String:Proposition] = [:]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Vérifie si on récupère une erreur
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // On vérifie l'état de la donnée
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
    
    //Donnée : Une proposition sur lequel on réalisera les itérations (sur idAnswers)
    //Résultat : Renvoie un tableau des réponses rattachées au propos associé
    static func getAllAnswer(proposition : Proposition)->[Answer]{
        var result : [Answer] = []
        let getAll : [Answer] = AnswerModel.getAll()
        var keys : [String] = []
        for ans in getAll {
            keys.append(ans.idPublication)
        }
        
        for it in 0..<getAll.count {
            for answer in proposition.answers {
                if answer == keys[it] {
                    result.append(getAll[it])
                }//arrêt : on a parcouru chaque id de réponse contenues dans notre propositions
            }
        }//arrêt :
        return result
    }
    
    //Données : Proposition prop
    //Résultat : Récupère la réponse avec le plus de likes, parmi les réponses associées à la proposition prop en paramètre
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
    
    //Donnée : Proposition prop
    //Résultat : Récupère tout les tags associés à la proposition prop
    static func getAllTags(proposition:Proposition)->[Tag]{
        var tagArray : [Tag] = []
        for tag in proposition.tags {
            tagArray.append((TagModel.getTagById(idTag: tag)))
        }
        return tagArray
    }
    
    //Données : un string caractérisant le type de tri, et une liste de tag pour filtrer les propositions que l'on récupèrera
    //Résultat : Renvoie un tableau de proposition contenant les propositions triées/filtrées en fonction des paramètres
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
    
    //Résultat : ajoute une proposition à la base de donnée en passant par une requête http de type POST
    static func addProposition(titleProp : String, contentPub: String, isAnonymous: Bool, tagsProp: [Tag], token: String) -> String{
        // Prepare URL
        
        let stringurl = "https://mootee-api.herokuapp.com/propositions/"
        let url = URL(string: stringurl)//ICI
        
        let tagsProp : String = paramTagsToLabel(tags: tagsProp)
        let body = [
            "titleProp" : titleProp,
            "contentProp" : contentPub,
            "isAnonymous" : "\(isAnonymous)",
            "tagsProp" : tagsProp
        ]
        
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let semaphore = DispatchSemaphore(value :0)
        var res : [String:String] = [:]
        // Set HTTP Request Body
        guard let requestBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return "noId"}
        
        request.httpBody = requestBody
        print(getFullToken(token: token))
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
            print("Test code status")
            print(res)
            if let data = data{
                print(data)
                do{
                    res = try JSONDecoder().decode([String:String].self, from: data)
                }
                catch let error {
                    print(error)
                }
                if let jsonString = String(data: data, encoding: .utf8){
                    print(jsonString)
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return purifyRequest(dictionary: res)[0] as! String
    }
    
    //Résultat : Supprime une proposition, renvoie true si c'est bon, false sinon
    static func deleteProposition(idProp: String, token: String)->Bool{
        // Prepare URL
        let stringurl = "https://mootee-api.herokuapp.com/propositions/"
        let url = URL(string: stringurl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
        var res : Bool = false
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let body = [
            "id": idProp
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

    //Données : un url (String), un id de proposition (String) et un token pour l'autorisation (String)
    //Résultat : renvoie true si la requête a bien été effectuée, false sinon
    static func propositionLD(url : String, idProposition : String, token : String)->Bool{
        // Prepare URL
        
        let stringurl = url
        let url = URL(string: stringurl)//ICI
        
        let body = [
            "id" : idProposition
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
    static func likeProp(idProposition : String, token : String)->Bool{
        print("propos liké")
        return propositionLD(url: "https://mootee-api.herokuapp.com/propositions/like", idProposition: idProposition, token: token)
    }
    
    //Données : un id de proposition (String) et un token pour l'autorisation (String)
    //Résultat : renvoie true si la proposition a bien été dislikée, false sinon
    static func dislikeProp(idProposition : String, token : String)->Bool{
        print("propos disliké")
        return propositionLD(url: "https://mootee-api.herokuapp.com/propositions/dislike", idProposition: idProposition, token: token)
    }
    
    //Résultat : renvoie true si la proposition a bien été modifiée (requête envoyée et validée), false sinon
     static func updateProp(idProp : String, ownerProp: String, isAnonymous : Bool, token : String)->Bool {
           // Prepare URL
           
           let stringurl = "https://mootee-api.herokuapp.com/propositions/"
           let url = URL(string: stringurl)//ICI
           
           let body = [
               "id" : idProp,
               "isAnonymous" : "\(isAnonymous)",
               "ownerProp" : ownerProp
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
    
    static func report(idProposition : String, token : String)->Bool{
        // Prepare URL
        let stringurl = "https://mootee-api.herokuapp.com/propositions/report"
        let url = URL(string: stringurl)//ICI
        
        let body = [
            "id" : idProposition
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
