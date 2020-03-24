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
        var propositions : [Proposition] = []
        for (_, value) in getAll() {
            propositions.append(value)
        }
        print(propositions.count)
        return propositions
    }
    
    static func getPropositionById(idProp : String)->Proposition!{
        return getAll()[idProp]
    }
    
    static func getAllAnswer(proposition : Proposition)->[Answer]{
        var answerArray : [Answer] = []
        for answer in proposition.answers {
            answerArray.append((AnswerModel.getAnswerById(idAns: answer)!))
        }
        return answerArray
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
            tagArray.append((TagModel.getTagById(idTag: tag)!))
        }
        return tagArray
    }
    
    static func getFilteredProps(filter: String, tags : [Tag]){
        //
    }

}
