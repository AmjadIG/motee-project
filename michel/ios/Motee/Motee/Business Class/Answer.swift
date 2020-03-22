//
//  Reponse.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import Foundation

class Answer : Publication, Identifiable, Codable {
    
    private var idPublication : String = "0"
    var datePublication : Date = Date()
    @Published var contentPub : String = ""
    @Published var idLikesAnswer : [String] = [] //Array d'object ID de User
    @Published var anonymous : Bool = false
    @Published var owner : User
    @Published var tags : [Tag] = []
    var idProposition : Proposition
        
    var id : String {return idPublication}
    
    enum AnswerEncodingKeys : CodingKey {
        case _id
        case dateAnswer
        case contentAnswer
        case idLikesAnswer
        case isAnonymous
        case ownerAnswer
        case tagAnswer
        case idProp
    }
    //Encoder
    func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: AnswerEncodingKeys.self)
        try container.encode(tags, forKey: .tagAnswer)
    }
    //Decoder by require init
    //No need of a second initializer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnswerEncodingKeys.self)
        self.idPublication = try container.decode(String.self, forKey: ._id)
        self.datePublication = try container.decode(Date.self, forKey: .dateAnswer)
        self.contentPub = try container.decode(String.self, forKey: .contentAnswer)
        self.idLikesAnswer = try container.decode(Array.self, forKey: .idLikesAnswer)
        self.anonymous = try container.decode(Bool.self, forKey: .isAnonymous)
        self.owner = try container.decode(User.self, forKey: .ownerAnswer)
        self.tags = try container.decode(Array.self, forKey: .tagAnswer)
        self.idProposition = try container.decode(Proposition.self, forKey: .idProp)
    }
    
    //methods
    
    func liker(userLike : User?){
        self.idLikesAnswer.append(userLike!.id)
    }
    
    func disliker(userDislike : User?){
        for i in 0..<self.idLikesAnswer.count {
            if self.idLikesAnswer[i] == userDislike!.id {
                self.idLikesAnswer.remove(at: i)
            }
        }
    }
    
    func estProprietaire(utilisateur: User)->Bool{
        if utilisateur.equals(utilisateur: self.owner) {
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
            return self.owner
        } else {
            return nil
        }
    }
    
    func estLikee(utilisateur: User?)->Bool{
        if utilisateur == nil {
            return false
        }
        var isLiked : Bool = false
        for it in 0..<idLikesAnswer.count {
            if idLikesAnswer[it] == utilisateur!.id {
                isLiked = true
            }
        }
        return isLiked
    }
}
