//
//  PropositionHeader.swift
//  Motee
//
//  Created by Rayan Bahroun on 4/1/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionHeader : View {
    @EnvironmentObject var fk : FilterKit
    @Binding var proposition : Proposition
    @Binding var colorIfClicked : Color
    @Binding var colorIfClicked2 : Color
    var body: some View {
        HStack{
            if proposition.owner != nil {
            if proposition.anonymous{
                Text("Anonyme").bold().foregroundColor(colorIfClicked2)
            }else{
                Text(UserModel.getUserById(idUser: proposition.owner).pseudo).bold().foregroundColor(colorIfClicked2)
            }
                if(self.proposition.owner == fk.currentUser?.idUser){
                if proposition.anonymous{
                    Button(action:{
                        self.proposition.anonymous = false
                        if PropositionModel.updateProp(idProp: self.proposition.idPublication, ownerProp: self.proposition.owner, isAnonymous: self.proposition.anonymous, token: self.fk.token){
                            self.fk.currentPage = self.fk.currentPage
                            print("Proposition updated")
                        }
                    }){
                        Image(systemName: "xmark.shield")
                    }
                }else{
                    Button(action:{
                        self.proposition.anonymous = true
                        if PropositionModel.updateProp(idProp: self.proposition.idPublication, ownerProp: self.proposition.owner, isAnonymous: self.proposition.anonymous, token: self.fk.token){
                            self.fk.currentPage = self.fk.currentPage
                            print("Proposition updated")
                        }
                    }){
                        Image(systemName: "lock.shield.fill")
                    }
                }
            }
            Spacer()
            Text(getGoodDate(wrongD: proposition.datePublication))
                .bold()
                .foregroundColor(colorIfClicked2)
            }else{
                Text("Chargement")
            }
        }.padding(.all, 10.0).background(LinearGradient(gradient: Gradient(colors: [.yellow, .pink]), startPoint: .leading, endPoint: .trailing))
    }
}
