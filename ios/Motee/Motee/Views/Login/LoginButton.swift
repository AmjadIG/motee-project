//
//  LoginButton.swift
//  Motee
//
//  Created by Rayan Bahroun on 27/02/2020.
//  Copyright © 2020 Rayan Bahroun. All rights reserved.
//

import SwiftUI

struct LoginButton: View {
    
    @EnvironmentObject var fk : FilterKit
    @Binding var pseudo : String
    @Binding var mdp : String
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
    
    func findConnexion(pseudo : String, mdp : String) -> Bool {
        if UserModel.checkAuthenticate(pseudo: pseudo, password: mdp).count>0{
            fk.token = UserModel.checkAuthenticate(pseudo: pseudo, password: mdp)[0] as! String
            fk.currentUSer = (UserModel.checkAuthenticate(pseudo: pseudo, password: mdp)[1] as! User)
            return true
        }else{
            return false
        }
    }
}


    /*for (_,value) in UserModel.getAll() {
        if(value.pseudo == pseudo && value.passwordProperties == mdp){
            return true
        }
    }
    return false */


struct loginButton_Previews: PreviewProvider {
    @State static var pseudo = "Pseudo"
    @State static var mdp = "mdp"
    static var previews: some View {
        LoginButton(pseudo : $pseudo, mdp : $mdp).environmentObject(FilterKit())
    }
}
