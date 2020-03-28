//
//  publicationLiked.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionLiked : View {
    @Binding var proposition : Proposition
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        VStack{
            if fk.currentUser != nil {
                Button(action:{
                    if self.proposition.estLikee(utilisateur: self.fk.currentUser){
                        self.proposition.disliker(userDislike: self.fk.currentUser!)
                        PropositionModel.dislikeProp(idProposition: self.proposition.id, token: self.fk.token)
                    }else{
                        self.proposition.liker(userLike: self.fk.currentUser!)
                        PropositionModel.likeProp(idProposition: self.proposition.id, token: self.fk.token)
                    }
                }){
                    HStack{
                        Text(String(proposition.idLikesProp.count))
                        if proposition.estLikee(utilisateur: fk.currentUser){
                            Image(systemName: "ear").foregroundColor(Color.red)
                        } else {
                            Image(systemName: "ear").foregroundColor(Color.black)
                        }
                        
                    }
                }
            }else{
                HStack{
                    Text(String(proposition.idLikesProp.count))
                    Image(systemName: "ear").foregroundColor(Color.black)
                    
                }
            }
        }
        
    }
}

struct PropositionLiked_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAll()[2]
    static var previews: some View {
        PropositionLiked(proposition : $proposition).environmentObject(FilterKit())
    }
}
