//
//  Utilisateur.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import Foundation

class User : Identifiable, ObservableObject, Codable {
    private var idUser : String = "0" //en attendant de récupérer les objectId
    @Published var pseudo : String
    private var password : String
    @Published var email : String
    @Published var city : String
    @Published var admin : Bool = false
    @Published var banned : Bool = false
    @Published var connected : Bool = false
    @Published var idPropositions : [Proposition] = []
    @Published var idAnswers : [Answer] = []
    
    var passwordProperties : String {
        get{
            return password
        }
        set{
            password = newValue
        }
    }
    
    var id : String {return email}
    
    //Enumeration utile pour l'encodage en JSON
    enum UserEncodingKeys : CodingKey {
        case _id
        case pseudo
        case mail
        case password
        case city
        case isAdmin
        case isConnected
        case isBanned
        case idPropositions
        case idAnswers
    }
    //Encoder
    func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: UserEncodingKeys.self)
        try container.encode(idPropositions, forKey: .idPropositions)
        try container.encode(idAnswers, forKey: .idAnswers)
    }
    //Decoder by require init
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserEncodingKeys.self)
        self.idUser = try container.decode(String.self, forKey: ._id)
        self.pseudo = try container.decode(String.self, forKey: .pseudo)
        self.email = try container.decode(String.self, forKey: .mail)
        self.password = try container.decode(String.self, forKey: .password)
        self.city = try container.decode(String.self, forKey: .city)
        self.admin = try container.decode(Bool.self, forKey: .isAdmin)
        self.banned = try container.decode(Bool.self, forKey: .isBanned)
        self.connected = try container.decode(Bool.self, forKey: .isConnected)
        self.idPropositions = try container.decode(Array.self, forKey: .idPropositions)
        self.idAnswers = try container.decode(Array.self, forKey: .idAnswers)
    }
    
    //main initializer ?
    
    //methods
    
    //Result : ban a user (in parameter) if we are an admin
    func bannirUtilisateur(utilisateurABannir : User)->Bool{
        if self.admin {
            utilisateurABannir.banned = true
            return true
        } else {
            return false
        }
    }
    
    //Result : return true if the User "equals" the user in parameter
    //Precision : a user is equal to another if its id is the same
    func equals(utilisateur: User)->Bool{
        if(utilisateur.id == self.id) {
            return true
        }else{
            return false
        }
    }
    
}
func getUserById(id : String) -> User {
    ///
    /// REQUETE POUR RECUPERER UN USER PAR SON ID
    ///
    //return User(pseudo: "obsolete", password: "obsolete", email: "obsolete", city: "obsolete")
}
