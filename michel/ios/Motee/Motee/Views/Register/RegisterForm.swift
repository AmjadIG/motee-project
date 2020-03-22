//
//  RegisterForm.swift
//  Motee
//
//  Created by Rayan Bahroun on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct RegisterForm: View {
    @State var pseudo : String = ""
    @State var mdp : String = ""
    @State var mdp2 : String = ""
    @State var mail : String = ""
    
    var body: some View {
        
        NavigationView{
            VStack{
                Title(myTitle: "Inscription")
                FieldGenerator.plain(label: "Pseudo :",field: "Pseudo", text: $pseudo)
                FieldGenerator.plain(label: "Mail :",field: "mail", text: $mail)
                FieldGenerator.secure(label: "Mot de passe :",field: "Mot de passe", text: $mdp)
                FieldGenerator.secure(label: "Confirmation mot de passe :",field: "Confirmation du mot de passe", text: $mdp2)
                RegisterButton(pseudo : $pseudo, mail : $mail, mdp : $mdp, mdp2 : $mdp2)
            }
        }
    }
}

struct RegisterForm_Previews: PreviewProvider {
    static var previews: some View {
        RegisterForm()
    }
}
