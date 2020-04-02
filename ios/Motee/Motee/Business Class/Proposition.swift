//
//  Propos.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import Foundation

class Proposition : Publication, Identifiable, Codable {
    
    @Published var idPublication : String = "0"
    @Published var datePublication : String = ""
    @Published var contentPub : String = ""
    @Published var idLikesProp : [String] = [] //Array d'object ID de User
    @Published var anonymous : Bool = false
    @Published var owner : String = ""
    @Published var tags : [String] = []
    @Published var answers : [String] = []
    @Published var title : String = ""
    @Published var idReport : [String] = []

    var id : String {return idPublication}
    
    //Enumération des Coding keys, utiles à l'encodage/décodage
    enum PropositionEncodingKeys : CodingKey {
        case _id
        case titleProp
        case dateProp
        case contentProp
        case idLikesProp
        case isAnonymous
        case ownerProp
        case tagsProp
        case idAnswers
    }
    
    //Résultat : Encode un objet de type Proposition, en son homologue JSON
    func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: PropositionEncodingKeys.self)
        try container.encode(tags, forKey: .tagsProp)
        try container.encode(answers, forKey: .idAnswers)
    }
    
    //Résultat : Décode un objet JSON en Proposition, à partir des Coding keys énumérées plus haut
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PropositionEncodingKeys.self)
        self.idPublication = try container.decode(String.self, forKey: ._id)
        self.title = try container.decode(String.self, forKey: .titleProp)
        self.datePublication = try container.decode(String.self, forKey: .dateProp)
        self.contentPub = try container.decode(String.self, forKey: .contentProp)
        self.idLikesProp = try container.decode(Array.self, forKey: .idLikesProp)
        self.anonymous = try container.decode(Bool.self, forKey: .isAnonymous)
        self.owner = try container.decode(String.self, forKey: .ownerProp)
        self.tags = try container.decode(Array.self, forKey: .tagsProp)
        self.answers = try container.decode(Array.self, forKey: .idAnswers)
        
    }
    
    func addAnswer(newAnswer: String)->Bool{
        self.answers.append(newAnswer)
        return true
    }
    
    func liker(userLike : User){
        self.idLikesProp.append(userLike.idUser)
        print(idLikesProp)
    }
    
    func disliker(userDislike : User){
        for i in 0..<self.idLikesProp.count {
            if self.idLikesProp[i] == userDislike.idUser {
                self.idLikesProp.remove(at: i)
            }
        }
        print(idLikesProp)
    }
    
    func estProprietaire(utilisateur: User)->Bool{
        if utilisateur.id == self.id {
            return true
        }else {
            return false
        }
    }
    
    func peutSupprimer(utilisateur: User) -> Bool {
        if(self.estProprietaire(utilisateur: utilisateur) || utilisateur.admin){
            return true
        }else{
            return false
        }
    }
    
    func revelerIdentitePublication(utilisateur : User)->User?{
        if utilisateur.admin && self.anonymous {
            //return self.owner
            return nil
        } else {
            return nil
        }
    }
    func estLikee(utilisateur: User?)->Bool{
        guard let utilisateur = utilisateur else {
            return false
        }
        var isLiked : Bool = false
        for idUser in self.idLikesProp{
            if idUser == utilisateur.idUser {
                isLiked = true
            }
        }
        return isLiked
    }

    func nbLike() -> Int {
        return self.idLikesProp.count
    }
    
    func dateToString() -> String {
        return datePublication
    }
}
