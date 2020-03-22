//
//  LoginButton.swift
//  Motee
//
//  Created by Rayan Bahroun on 27/02/2020.
//  Copyright © 2020 Rayan Bahroun. All rights reserved.
//

import SwiftUI

struct LoginButton: View {
    
    //var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    @State var pseudo = ""
    @State var mdp = ""
    @State var canConnect = false
    
    var body: some View {
        VStack{
            if(findConnexion(pseudo: pseudo, mdp: mdp)){
                NavigationLink(destination : Accueil()){
                    ButtonGenerator(myText: "Se connecter", myColor: "green")
                }
            }
            else{
                Button(action : { self.canConnect.toggle()}){
                ButtonGenerator(myText: "Se connecter", myColor: "red")
                   .offset(x: canConnect ? -10 : 0) .animation(Animation.default.repeatCount(5))
                }
            }
        }.padding(.bottom , 10)
            .padding(.top , 30)
    }
}

func findConnexion(pseudo : String, mdp : String) -> Bool {
    for user in UserDAO.getAll() {
        if(user.pseudo == pseudo && user.passwordProperties == mdp){
            return true
        }
    }
    return false
}

struct loginButton_Previews: PreviewProvider {
    @State static var pseudo = "Pseudo"
    @State static var mdp = "mdp"
    static var previews: some View {
        LoginButton(pseudo : "", mdp : "")
    }
}
