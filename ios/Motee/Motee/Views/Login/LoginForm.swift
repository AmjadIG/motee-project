//
//  loginForm.swift
//  exemple
//
//  Created by Rayan Bahroun on 19/02/2020.
//  Copyright © 2020 Rayan Bahroun. All rights reserved.
//

import SwiftUI

struct LoginForm: View {
    @EnvironmentObject var fk : FilterKit
    @State var pseudo : String = ""
    @State var mdp : String = ""
    @State var noError : Bool = true
    var body: some View {
        NavigationView{
            VStack{
                Title(myTitle: "Connexion")
                LoginPicture()
                if !noError{
                    Text("Pseudo ou mdp incorrect").foregroundColor(Color.red)
                }
                FieldGenerator.plain(label: "",field: "Pseudo", text: $pseudo)
                FieldGenerator.secure(label: "",field: "Mot de passe", text: $mdp)
                Button(action: {
                    self.findConnexion(pseudo: self.pseudo, mdp: self.mdp)
                    self.noError = self.findConnexion(pseudo: self.pseudo, mdp: self.mdp)
                }){
                    ButtonGenerator(myText: "Se connecter", myColor: "green").padding()
                }
                //LoginButton(pseudo: $pseudo,mdp: $mdp)
                NavigationLink(destination : RegisterForm()){
                    ButtonGenerator(myText: "S'inscrire", myColor: "blue")
                }
            }
        }
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

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
