//
//  RegisterButton.swift
//  Motee
//
//  Created by Rayan Bahroun on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct RegisterButton: View {
    @Binding var pseudo : String
    @Binding var mail : String
    @Binding var mdp : String
    @Binding var mdp2 : String
    var body: some View {
        VStack{
            if(availableRegistration(pseudo: pseudo, mail: mail, mdp: mdp, mdp2: mdp2)){
                NavigationLink(destination : LoginForm()){
                    ButtonGenerator(myText: "S'inscrire", myColor: "blue")
                }
            }else{
                ButtonGenerator(myText: "S'inscrire", myColor: "red")
            }
            
        }
        .padding(.top , 10)
    }
}

func availableRegistration(pseudo : String, mail : String, mdp : String, mdp2 : String ) -> Bool {
    return(isAvailablePseudo(pseudo : pseudo)
        && isSamePasword(mdp1: mdp, mdp2: mdp2) && isAvailablePassword(mdp : mdp)
        && isAvailableMail(mail : mail)
    )
}

func isAvailablePseudo(pseudo : String) -> Bool{
    for (_,value) in UserModel.getAll() {
        if value.pseudo == pseudo {
            return false
        }
    }
    return true
}

func isAvailablePassword(mdp : String)->Bool {
    for (_,value) in UserModel.getAll() {
        if value.passwordProperties == mdp {
            return false
        }
    }
    return true
}
func isSamePasword(mdp1 : String ,mdp2 : String) -> Bool{
    return (mdp1 == mdp2 && mdp1.count > 3)
}

func isAvailableMail(mail : String) -> Bool {
    for (_,value) in UserModel.getAll() {
        if value.email == mail {
            return false
        }
    }
    return true
}

struct RegisterButton_Previews: PreviewProvider {
    @State static var pseudo = "Pseudo"
    @State static var mail = "mail"
    @State static var mdp = "mdp"
    @State static var mdp2 = "mdp"
    static var previews: some View {
        RegisterButton(pseudo : $pseudo, mail : $mail , mdp : $mdp, mdp2 : $mdp2 )
    }
}
