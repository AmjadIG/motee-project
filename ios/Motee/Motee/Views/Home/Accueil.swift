//
//  Accueil.swift
//  Motee
//
//  Created by Rayan Bahroun on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct Accueil: View {
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    LoginBanner()
                    TopTags()
                    VStack(){
                        FilterTitle()
                        if(fk.currentUser != nil){
                            HStack{
                                NavigationLink(destination : { AddProposition() }() ){
                                    SymbolGenerator(mySymbol :"plus.square.fill", myColor: "pink")
                                    Text("Ajouter").foregroundColor(.black).bold()
                                }
                            }.padding()
                        }
                        PropositionFiltred(filtre: fk.filtered, tags: fk.tags)
                        Spacer()
                    }
                    Spacer()
                    }
            }
        }
    }
}

struct Accueil_Previews: PreviewProvider {
    static var previews: some View {
        Accueil().environmentObject(FilterKit())
    }
}
