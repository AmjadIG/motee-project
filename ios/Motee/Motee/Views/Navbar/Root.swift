//
//  Root.swift
//  Motee
//
//  Created by Rayan Bahroun on 07/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI

struct Root : View {
    var currentPage : String
    var body: some View {
        VStack{
            if(currentPage == "Accueil"){
                Accueil()
            }else if currentPage == "Login" {
                LoginForm()
            }else if currentPage == "Compte"{
                Account()
            }
            else{
                Accueil()
            }
        }
    }
}

struct Root_Previews: PreviewProvider {
    @State static var page = "login"
    @State static var filter = "all"
    static var previews: some View {
        Root(currentPage: page).environmentObject(FilterKit())
    }
}
