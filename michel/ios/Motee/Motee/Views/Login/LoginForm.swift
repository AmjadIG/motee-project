//
//  loginForm.swift
//  exemple
//
//  Created by Rayan Bahroun on 19/02/2020.
//  Copyright © 2020 Rayan Bahroun. All rights reserved.
//

import SwiftUI

struct LoginForm: View {
    
    @State var pseudo : String = ""
    @State var mdp : String = ""
    var body: some View {
        NavigationView{
            VStack{
                Title(myTitle: "Connexion")
                LoginPicture()
                FieldGenerator.plain(label: "",field: "Pseudo", text: $pseudo)
                FieldGenerator.secure(label: "",field: "Mot de passe", text: $mdp)
                LoginButton(pseudo: pseudo,mdp: mdp)
                NavigationLink(destination : RegisterForm()){
                    ButtonGenerator(myText: "S'inscrire", myColor: "blue")
                }
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
