//
//  publicationLiked.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionLiked : View {
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    var proposition : Proposition
    
    init(proposition : Proposition) {
        self.proposition = proposition
    }
    
    var body: some View {
        Button(action:{
            if self.proposition.estLikee(utilisateur: self.currentUser){
                self.proposition.disliker(userDislike: self.currentUser)
            }else{
                self.proposition.liker(userLike: self.currentUser)
            }
        }){
            HStack{
                if proposition.estLikee(utilisateur: currentUser){
                    Image(systemName: "heart.fill").foregroundColor(Color.red)
                } else {
                    Image(systemName: "heart").foregroundColor(Color.black)
                }
                Text(String(proposition.idLikesProp.count))
            }
        }
    }
}
/*
struct PropositionLiked_Previews: PreviewProvider {
    static var previews: some View {
        PublicationLiked()
    }
}*/
