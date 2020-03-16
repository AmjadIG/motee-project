//
//  UserDAO.swift
//  Motee
//
//  Created by Amjad Menouer on 13/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Foundation

class UserDAO {
    
    let rootURI : String = "https://_.herokuapp.com/users/"

    //----------------------------------
    //---------- GET requests ----------
    //----------------------------------
    
    func getUserById(userId : String)->User{
        // Prepare URL
        let stringURL = self.rootURI+"get?token="+userId
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
         
        // Perform HTTP Request
        var resArray : [User] = []
        var res : User
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place :\(error)")
                    return
                }
            
                // Convert HTTP Response Data to a String
                if let data = data{
                    
                    do{
                        resArray = try JSONDecoder().decode([User].self, from: data)
                        for iterator in 0..<resArray.count-1 {
                            if(userId == resArray[iterator].id){
                                res = resArray[iterator]
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
    /*
    func getUserByProposition(propositionId : String)->User{
        // Prepare URL
        let stringURL = self.rootURI+"get?props?token="+propositionId
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
         
        // Perform HTTP Request
        var resArray : [User] = []
        var res : User
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place :\(error)")
                    return
                }
            
                // Convert HTTP Response Data to a String
                if let data = data{
                    
                    do{
                        resArray = try JSONDecoder().decode([User].self, from: data)
                        for iterator in 0..<resArray.count-1 {
                            if(propositionId == resArray[iterator].id){
                                res = resArray[iterator]
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
    }*/
    
    func getUserByAnswer()->User{}
    
    func getUsersByCity(city : String)->[User]{
        // Prepare URL
        let stringURL = self.rootURI+"get?city="+city
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
         
        // Perform HTTP Request
        var resArray : [User] = []
        var res : [User] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                
                do{
                    resArray = try JSONDecoder().decode([User].self, from: data)
                    for iterator in 0..<resArray.count-1 {
                        if(city == resArray[iterator].city){
                            res.append(resArray[iterator])
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
    
    func getAll()->[User]{
        // Prepare URL
        let stringURL = self.rootURI+"get?all"
        let url = URL(string: stringURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object (GET)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
        // Perform HTTP Request
        var res : [User] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place :\(error)")
                return
            }
        
            // Convert HTTP Response Data to a String
            if let data = data{
                do{
                    res = try JSONDecoder().decode([User].self, from: data)
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

    func postUser(user : User, token : String){
        var tagId : String? = nil
        // Prepare URL
        let stringurl = "https://_.herokuapp.com/users/add?token=" + token
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
            request.httpBody = try JSONEncoder().encode(user)
            
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
    } //add User

    //----------------------------------
    //---------- PUT requests ----------
    //----------------------------------

    func putUser(){
        
    } //add User
    
    //----------------------------------
    //---------- DELETE requests -------
    //----------------------------------
    
    func deleteUserById(userId : String)->Bool{
        // Prepare URL
        let stringurl = self.rootURI+"delete?token="+userId
        let url = URL(string: stringurl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
         
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "id="+userId; //userId is _id of User (ObjectId)
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
