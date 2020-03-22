//
//  PropositionDAO.swift
//  Motee
//
//  Created by Amjad Menouer on 13/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

// That's a light okay... maybe we need more properties for ou DAO
import SwiftUI
import Foundation

class PropositionDAO {
    
    static var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    static let rootURI : String = "https://_.herokuapp.com"
    //----------------------------------
    //---------- GET requests ----------
    //----------------------------------
    
    static func getAll()->[Proposition]{
        // Prepare URL
        let stringURL = self.rootURI+"get?all"
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
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

    //Result : Post a proposition
    func postProps (proposition : Proposition, token : String) -> Bool{
           var propositionId : String? = nil
           // Prepare URL
           let stringurl = "https://_.herokuapp.com/propositions/add?token=" + token
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
               request.httpBody = try JSONEncoder().encode(proposition)
               
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
                       
                        propositionId = String(jsonString.dropFirst().dropLast())
                        print("new string : " + propositionId!)
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

    //Result : Add a Proposition
    func putProps(idProposition : String, token : String) -> Bool {
        // Prepare URL
        let preString = "https://_.herokuapp.com/answer" //??
        let postString = "?id="+String(idProposition) + "&token=" + token
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
    
    func deleteProps(propositionId : String, token : String) -> Bool{
        // Prepare URL
        let stringurl = "https://_.herokuapp.com/propositions/delete?token="+token
        let url = URL(string: stringurl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
         
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "id="+propositionId;
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
