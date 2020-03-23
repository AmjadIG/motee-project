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
    
    private var idPublication : String = "0"
    var datePublication : String = ""
    @Published var contentPub : String = ""
    @Published var idLikesProp : [String] = [] //Array d'object ID de User
    @Published var anonymous : Bool = false
    @Published var owner : String = ""
    @Published var tags : [String] = []
    @Published var answers : [String] = []

    var id : String {return idPublication}
    
    enum PropositionEncodingKeys : CodingKey {
        case _id
        case dateProp
        case contentProp
        case idLikesProp
        case isAnonymous
        case ownerProp
        case tagsProp
        case idAnswers
    }
    //Encoder
    func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: PropositionEncodingKeys.self)
        try container.encode(tags, forKey: .tagsProp)
        try container.encode(answers, forKey: .idAnswers)
    }
    //Decoder by require init
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PropositionEncodingKeys.self)
        self.idPublication = try container.decode(String.self, forKey: ._id)
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
    
    func liker(userLike : User?){
        self.idLikesProp.append(userLike!.id)
    }
    
    func disliker(userDislike : User?){
        for i in 0..<self.idLikesProp.count {
            if self.idLikesProp[i] == userDislike!.id {
                self.idLikesProp.remove(at: i)
            }
        }
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
        if utilisateur == nil {
            return false
        }
        var isLiked : Bool = false
        for it in 0..<idLikesProp.count {
            if idLikesProp[it] == utilisateur!.id {
                isLiked = true
            }
        }
        return isLiked
    }
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy à HH:mm"
        return formatter.string(from: self.datePublication)
    }
}
