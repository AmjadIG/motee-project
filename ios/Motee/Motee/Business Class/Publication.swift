//
//  Publication.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import Foundation

protocol Publication {

    func liker(userLike : User)
    
    func disliker(userDislike : User)
    
    func estProprietaire(utilisateur: User)->Bool
    
    func peutSupprimer(utilisateur: User) -> Bool
    
    func revelerIdentitePublication(utilisateur : User)->User?
    
    func estLikee(utilisateur: User?)->Bool
}
