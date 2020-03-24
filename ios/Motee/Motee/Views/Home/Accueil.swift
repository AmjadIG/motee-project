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
                    TopTags()
                    VStack(){
                        if(self.fk.filtered.elementsEqual("byLike")){
                            Title(myTitle: "Les meilleurs propos")
                        }else if self.fk.filtered.elementsEqual("desc"){
                            Title(myTitle: "Propos les plus récents")
                        }else if self.fk.filtered.elementsEqual("asc"){
                            Title(myTitle: "Propos les plus anciens")
                        }
                        HStack{
                            NavigationLink(destination : { AddProposition() }() ){
                                SymbolGenerator(mySymbol :"plus.square.fill", myColor: "pink")
                                Text("Ajouter").foregroundColor(.black).bold()
                            }
                        }
                        PropositionFiltred()
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
