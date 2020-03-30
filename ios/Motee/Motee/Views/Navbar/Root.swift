//
//  Root.swift
//  Motee
//
//  Created by Rayan Bahroun on 07/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI

struct Root : View {
    @EnvironmentObject var fk : FilterKit
    var currentPage : String
    var body: some View {
        VStack{
            if(fk.currentPage == "Accueil"){
                Accueil()
            }else if fk.currentPage == "Sign in" {
                LoginForm()
            }else if fk.currentPage == "Compte"{
                Account()
            }else if fk.currentPage == "Sign up"{
                RegisterForm()
            }else if fk.currentPage == "Mes propositions"{
                MyProps(props: UserModel.getPropsByUser(user: fk.currentUser!))
            }else if fk.currentPage == "Mes réponses"{
                MyAnswers(answers: UserModel.getAnswersByUser(user: fk.currentUser!))
                }
            else if fk.currentPage == "Ajouter propos"{
                AddProposition()
            }
            else{
                Accueil()
            }
        }
    }
}

struct Root_Previews: PreviewProvider {
    @State static var page = "Sign in"
    static var previews: some View {
        Root(currentPage: page).environmentObject(FilterKit())
    }
}
