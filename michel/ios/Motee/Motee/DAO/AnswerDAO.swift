//
//  AnswerDAO.swift
//  Motee
//
//  Created by Amjad Menouer on 12/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//


// That's a light okay... maybe we need more properties for ou DAO
import SwiftUI
import Foundation

public class AnswerDAO {

    //Get : byLikes, byDate
    //Post : ajout
    //Put : ~Update (if Owner)
    //Delete : (if Admin or Owner)
    static var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    static let rootURI : String = "https://..."

    //----------------------------------
    //---------- GET requests ----------
    //----------------------------------

    static func getAll()->[Answer]{
        // Prepare URL
        let stringURL = self.rootURI+"get?all"
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        // Perform HTTP Request
        var res : [Answer] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([Answer].self, from: data)
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
    
    static func getAnswersByPropId(propId : String)->[Answer]{
        // Prepare URL
        let stringURL = self.rootURI+"get?answers?by?id="+propId
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        // Perform HTTP Request
        var allAnswers : [Answer] = []
        var res : [Answer] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    allAnswers = try JSONDecoder().decode([Answer].self, from: data)
                    for it in 0..<allAnswers.count {
                        if allAnswers[it].idProposition.id == propId {
                            res.append(allAnswers[it])
                        }
                    }
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

    //----------------------------------
    //---------- POST requests ---------
    //----------------------------------

    //Result : Post an answer
    static func postAnswer (answer : Answer, token : String) -> Bool{
           var answerId : String? = nil
           // Prepare URL
           let stringurl = "https://_.herokuapp.com/answers/add?token=" + token
           let url = URL(string: stringurl)//ICI
           guard let requestUrl = url else { fatalError() }
           // Prepare URL Request Object
           var request = URLRequest(url: requestUrl)
           request.httpMethod = "POST"
           let semaphore = DispatchSemaphore(value :0)
           var res : Bool = false
           // Set HTTP Request Body
           do{
               //try  print(JSONSerialization.jsonObject(with: JSONEncoder().encode(rem), options: []))
               //let json = try JSONSerialization.jsonObject(with: JSONEncoder().encode(rem), options: [])
               request.httpBody = try JSONEncoder().encode(answer)
               
           }catch let error {
               print(error)
           }
        
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           //print("json : " , String(data : request.httpBody!, encoding: .utf8)!)
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
                       
                        answerId = String(jsonString.dropFirst().dropLast())
                        print("new string : " + answerId!)
                   }
               }
               semaphore.signal()
           }
           task.resume()
           semaphore.wait()
           
           return res
    }
    

    //----------------------------------
    //---------- PUT requests ----------
    //----------------------------------

    //Result : Add an Answer
    static func putAnswer(idAnswer : String, token : String) -> Bool {
        // Prepare URL
        let preString = "https://_.herokuapp.com/answer" //??
        let postString = "?id="+String(idAnswer) + "&token=" + token
        let url = URL(string: preString+postString)

        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"

        let semaphore = DispatchSemaphore(value :0)
         
        // Perform HTTP Request
        var res : Bool = false
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            } else {
                let resp = response as? HTTPURLResponse
                res = (resp?.statusCode == 200) //true si on a bien increment le tag
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8){
                        print(jsonString)
                    }
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        return res
    }
    
    //----------------------------------
    //---------- DELETE requests -------
    //----------------------------------
    
    static func deleteAnswer(answerId : String, token : String) -> Bool{
        // Prepare URL
        let stringurl = "https://_.herokuapp.com/answers/delete?token="+token
        let url = URL(string: stringurl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
         
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "id="+answerId;
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        var res : Bool = false
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
