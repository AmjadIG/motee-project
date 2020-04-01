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
                    //if the user already liked the proposition we can dislike
                    if self.proposition.estLikee(utilisateur: self.fk.currentUser){
                        self.proposition.disliker(userDislike: self.fk.currentUser!)
                        // if the querry to dislike the proposition worked
                        if PropositionModel.dislikeProp(idProposition: self.proposition.idPublication, token: self.fk.token){
                            self.fk.currentPage = self.fk.currentPage
                            print("Proposition disliked")
                        }else{
                            print("error Proposition not disliked")
                        }
                    }
                        // the user can like the propostion
                    else{
                        self.proposition.liker(userLike: self.fk.currentUser!)
                        if PropositionModel.likeProp(idProposition: self.proposition.idPublication, token: self.fk.token){
                            self.fk.currentPage = self.fk.currentPage
                            print("Proposition liked")
                        }else{
                            print("error Proposition not liked")
                        }
                    }
                }){
                    HStack{
                        Text(String(self.proposition.nbLike()))
                        if proposition.estLikee(utilisateur: fk.currentUser){
                            Image(systemName: "ear").foregroundColor(Color.red)
                        } else {
                            Image(systemName: "ear").foregroundColor(Color.black)
                        }
                        
                    }
                }
            }else{
                HStack{
                    Text(String(proposition.nbLike()))
                    Image(systemName: "ear").foregroundColor(Color.gray)
                    
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
