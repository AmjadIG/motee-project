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
    
    @Published var idPublication : String = "0"
    @Published var datePublication : String = ""
    @Published var contentPub : String = ""
    @Published var idLikesAnswer : [String] = [] //Array d'object ID de User
    @Published var tagsAnswer : [String] = []
    @Published var anonymous : Bool = false
    @Published var owner : String
    @Published var idReport : [String] = []
    var idProposition : String
        
    var id : String {return idPublication}
    
    //Enumération des Coding keys, utiles à l'encodage/décodage
    enum AnswerEncodingKeys : CodingKey {
        case _id
        case dateAnswer
        case contentAnswer
        case idLikesAnswer
        case tagsAnswer
        case isAnonymous
        case ownerAnswer
        case idProp
        case idReport
    }
    //Résultat : Encode un objet de type Proposition, en son homologue JSON
    func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: AnswerEncodingKeys.self)
    }
    
    //Résultat : Décode un objet JSON en Proposition, à partir des Coding keys énumérées plus haut
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnswerEncodingKeys.self)
        self.idPublication = try container.decode(String.self, forKey: ._id)
        self.datePublication = try container.decode(String.self, forKey: .dateAnswer)
        self.contentPub = try container.decode(String.self, forKey: .contentAnswer)
        self.idLikesAnswer = try container.decode(Array.self, forKey: .idLikesAnswer)
        self.tagsAnswer = try container.decode(Array.self, forKey: .tagsAnswer)
        self.anonymous = try container.decode(Bool.self, forKey: .isAnonymous)
        self.owner = try container.decode(String.self, forKey: .ownerAnswer)
        self.idProposition = try container.decode(String.self, forKey: .idProp)
        self.idReport = try container.decode(Array.self, forKey: .idReport)

    }
    
    //methods
    
    func liker(userLike : User){
        self.idLikesAnswer.append(userLike.idUser)
    }
    
    func disliker(userDislike : User){
        for i in 0..<self.idLikesAnswer.count {
            if self.idLikesAnswer[i] == userDislike.idUser {
                self.idLikesAnswer.remove(at: i)
            }
        }
    }
    
    func estProprietaire(utilisateur: User)->Bool{
        return utilisateur.id == self.id
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
        for idUser in self.idLikesAnswer {
            if idUser == utilisateur.idUser {
                isLiked = true
            }
        }
        return isLiked
    }
}
