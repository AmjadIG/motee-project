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
            if(fk.currentPage == "home"){
                Accueil()
            }else if fk.currentPage == "login" {
                LoginForm()
            }else if fk.currentPage == "Compte"{
                Account()
            }else if fk.currentPage == "register"{
                RegisterForm()
            }
            else{
                Accueil()
            }
        }
    }
}

struct Root_Previews: PreviewProvider {
    @State static var page = "login"
    static var previews: some View {
        Root(currentPage: page).environmentObject(FilterKit())
    }
}
