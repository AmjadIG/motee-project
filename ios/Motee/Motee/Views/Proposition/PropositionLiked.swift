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
            if fk.currentUSer != nil {
                Button(action:{
                    if self.proposition.estLikee(utilisateur: self.fk.currentUSer){
                        self.proposition.disliker(userDislike: self.fk.currentUSer!)
                    }else{
                        self.proposition.liker(userLike: self.fk.currentUSer!)
                    }
                }){
                    HStack{
                        if proposition.estLikee(utilisateur: fk.currentUSer){
                            Image(systemName: "heart.fill").foregroundColor(Color.red)
                        } else {
                            Image(systemName: "heart").foregroundColor(Color.black)
                        }
                        Text(String(proposition.idLikesProp.count))
                    }
                }
            }else{
                HStack{
                    Image(systemName: "heart").foregroundColor(Color.black)
                    Text(String(proposition.idLikesProp.count))
                }
            }
        }
        
    }
}

struct PropositionLiked_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAllProps()[2]
    static var previews: some View {
        PropositionLiked(proposition : $proposition).environmentObject(FilterKit())
    }
}
