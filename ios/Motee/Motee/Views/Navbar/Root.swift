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
    var body: some View {
        VStack{
            if(fk.currentPage == "Accueil"){
                Accueil()
            }else if fk.currentPage == "Se connecter" {
                LoginForm()
            }else if fk.currentPage == "Compte"{
                Account()
            }else if fk.currentPage == "S'inscrire"{
                RegisterForm()
            }else if fk.currentPage == "Mes propositions"{
                MyProps()
            }else if fk.currentPage == "Mes réponses"{
                MyAnswers()
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
    @State static var page = "Se connecter"
    static var previews: some View {
        Root().environmentObject(FilterKit())
    }
}
