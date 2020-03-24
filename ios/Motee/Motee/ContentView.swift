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
            //NavbarView()
            
            //LoginForm()
            //Accueil()
            Button(action:{
                print(paramTags(tags: purifyRequest(dictionary: TagModel.getAll()) as! [Tag]))
            }){
                ButtonGenerator(myText: "Test tags", myColor: "red")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
