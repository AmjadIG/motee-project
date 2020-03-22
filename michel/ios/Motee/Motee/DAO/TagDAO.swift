//
//  TagDAO.swift
//  Motee
//
//  Created by Amjad Menouer on 12/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

// That's a light okay... maybe we need more properties for ou DAO
import SwiftUI
import Foundation

class TagDAO {
    
    static var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    let rootURI : String = "https://..."
    
    //------------------
    //-- GET REQUESTS --
    //------------------
    
    func getAll()->[Tag]{
        // Prepare URL
        let stringURL = self.rootURI+"get?all"
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        // Perform HTTP Request
        var res : [Tag] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([Tag].self, from: data)
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
    
    //Get Tag by its Label
    //Result : return an array of 1 Tag who got "label" as its label, or else, it will be the full array of Tags in database...
    func getByLabel(label : String)->[Tag] {
        // Prepare URL
        let preString = "https://..."
        //let postString = "?_="+String(_)+"&_="+String(_)+"&_="+String(_)
        let url = URL(string: preString/*+postString*/)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
         
        // Perform HTTP Request
        var res : [Tag] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place :\(error)")
                    return
                }
            
                // Convert HTTP Response Data to a String
                if let data = data{
                    
                    do{
                        res = try JSONDecoder().decode([Tag].self, from: data)
                        for iterator in 0..<res.count{
                            if (res[iterator].label == label) {
                                var result : Tag
                                result = res[iterator]
                                res.removeAll()
                                res.append(result)
                                break
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
        
        return res //Logically an array of only 1 tag or all Tags if the label is not found :/
    }
    
    //Sort Tags by number of occurences
    func getSortedByNbOccurences()->[Tag] {
        // Prepare URL
        let preString = "https://..."
        //let postString = "?_="+String(_)+"&_="+String(_)+"&_="+String(_)
        let url = URL(string: preString/*+postString*/)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
         
        // Perform HTTP Request
        var res : [Tag] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place :\(error)")
                    return
                }
            
                // Convert HTTP Response Data to a String
                if let data = data{
                    
                    do{
                        res = try JSONDecoder().decode([Tag].self, from: data)
                        res.sort(by: { $0.nbOccurences > $1.nbOccurences}) //Sort by number of uses => Tag[0] more used than Tag[1]
                        
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
    
    
    //-------------------
    //-- POST REQUESTS --
    //-------------------
    
    func postTag (tag : Tag, token : String) -> Bool{
           var tagId : String? = nil
           // Prepare URL
           let stringurl = "https://_.herokuapp.com/tags/add?token=" + token
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
               request.httpBody = try JSONEncoder().encode(tag)
               
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
                       
                        tagId = String(jsonString.dropFirst().dropLast())
                        print("new string : " + tagId!)
                   }
               }
               semaphore.signal()
           }
           task.resume()
           semaphore.wait()
           
           return res
    }
    
    //------------------
    //-- PUT REQUESTS --
    //------------------
    
    //Result : Add a Tag
    func putTag(idTag : String, token : String) -> Bool {
        // Prepare URL
        let preString = "https://_.herokuapp.com/proposition/tags" //??
        let postString = "?id="+String(idTag) + "&token=" + token
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
    
    //---------------------
    //-- DELETE REQUESTS --
    //---------------------
    
    
    //Result : Delete tag 
    func deleteTag(tagId:String, label : String)-> Bool{
        // Prepare URL
        let stringurl = "https://_.herokuapp.com/answers/delete?token="+label
        let url = URL(string: stringurl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
         
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "id="+tagId; //tagId is _id of Tag (ObjectId)
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
                    res = (resp?.statusCode == 200) //true if the response we get has 200 as a status code (Success)
                
        }
        task.resume()
        return res
    }
    
}
