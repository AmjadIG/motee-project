//
//  MenuView.swift
//  Motee
//
//  Created by Rayan Bahroun on 07/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI


struct MenuView: View {
    @EnvironmentObject var fk : FilterKit
    @Binding var showMenu : Bool
    var body: some View {
        VStack(alignment: .leading) {
            Button(action : {
                self.fk.currentPage = "Accueil"
                self.showMenu.toggle()
            }){
                SingleLinkNavBar(title: "Accueil", symbol: "house", topPadding: 170)
            }
            Button(action : {
                if self.fk.currentUser == nil {
                    self.fk.currentPage = "Sign in"
                }else{
                    self.fk.currentPage = "Ajouter propos"
                }
                self.showMenu.toggle()
            }){
                SingleLinkNavBar(title: "Ajouter un propos", symbol: "plus.square", topPadding: 30)
            }
            Button(action : {
                if self.fk.currentUser == nil {
                    self.fk.currentPage = "Sign in"
                }else{
                    self.fk.currentPage = "Mes propositions"
                }
                self.showMenu.toggle()
            }){
                SingleLinkNavBar(title: "Mes propos", symbol: "quote.bubble", topPadding: 30)
            }
            Button(action : {
                if self.fk.currentUser == nil {
                    self.fk.currentPage = "Sign in"
                }else{
                    self.fk.currentPage = "Mes réponses"
                }
                self.showMenu.toggle()
            }){
                SingleLinkNavBar(title: "Mes réponses", symbol: "lightbulb", topPadding: 30)
            }
            Button(action : {
                if self.fk.currentUser == nil {
                    self.fk.currentPage = "Sign in"
                }else{
                    self.fk.currentPage = "Compte"
                }
                self.showMenu.toggle()
            }){
                SingleLinkNavBar(title: "Profil", symbol: "person", topPadding: 30)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var showMenu = false
    static var previews: some View {
        MenuView(showMenu: $showMenu).environmentObject(FilterKit())
    }
}
