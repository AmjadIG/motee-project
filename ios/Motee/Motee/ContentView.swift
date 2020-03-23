//
//  ContentView.swift
//  Motee
//
//  Created by Rayan Bahroun on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var filterKit : FilterKit
    @State var boolTest : Bool = false
    
    var body: some View {
        VStack{
            /*NavbarView()
            LoginForm()*/
            //Accueil()
            Button(action:{
                if !UserModel.getAll().isEmpty {
                    self.boolTest = true
                    for(_, value) in UserModel.getAll(){
                        print(value.pseudo)
                        print(value.email)
                        print()
                    }
                }
            }){
                ButtonGenerator(myText: "Users", myColor: "red")
            }
            if boolTest {
                ButtonGenerator(myText: "Requete ok!", myColor: "blue")
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
