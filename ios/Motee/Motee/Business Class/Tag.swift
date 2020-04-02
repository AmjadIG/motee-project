//
//  Tag.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import Foundation

class Tag : Identifiable, ObservableObject, Codable {
    private var idTag : String = "" //Object Id
    @Published var label : String
    @Published var nbOccurences : Int = 0
    
    var id : String {return self.idTag}
    
    private var idPropositions : [String] = []
    private var idAnswers : [String] = []
    
    //Enumération des Coding keys, utiles à l'encodage/décodage
    enum TagEncodingKeys : CodingKey {
        case _id
        case label
        case nbOccurence
        case idProps
        case idAnswers
    }
    
    //Résultat : Encode un objet de type Proposition, en son homologue JSON
    func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: TagEncodingKeys.self)
        try container.encode(idPropositions, forKey: .idProps)
        try container.encode(idAnswers, forKey: .idAnswers)
    }
    
    //Résultat : Décode un objet JSON en Proposition, à partir des Coding keys énumérées plus haut
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TagEncodingKeys.self)
        self.idTag = try container.decode(String.self, forKey: ._id)
        self.label = try container.decode(String.self, forKey: .label)
        self.nbOccurences = try container.decode(Int.self, forKey: .nbOccurence)
        self.idPropositions = try container.decode(Array.self, forKey: .idProps)
        self.idAnswers = try container.decode(Array.self, forKey: .idAnswers)
    }
    
    //Main initializer
    init(label : String) {
        self.label = label
    }
    
    func nbOccurence(labelTag : String){
        //Get all the tag with label = labelTag
        //if tag is attached to publication => +1
        
        //var nbOccurencesTag : Int = 0
        //boucle for => JSON
    }
    
    func equals(otherTag : Tag)->Bool{
        return self.label == otherTag.label
    }
}

// get the best 9 tags
func getTopTags() -> [Tag] {
    /// REQUETE
    return [Tag(label: "Humour"),Tag(label: "Metro"),Tag(label: "Paris"),
            Tag(label: "Sport"),Tag(label: "Corona"),Tag(label: "Drague"),
            Tag(label: "Travail"),Tag(label: "Tenue"),Tag(label: "Famille")
            ]
}
