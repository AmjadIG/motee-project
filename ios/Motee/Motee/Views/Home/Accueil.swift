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
                        if(self.fk.filtered.elementsEqual("all")){
                            Title(myTitle: "Tous les propos")
                        }else if self.fk.filtered.elementsEqual("like"){
                            Title(myTitle: "Les meilleurs propos")
                        }else if self.fk.filtered.elementsEqual("dateDesc"){
                            Title(myTitle: "Les plus récents propos")
                        }else if self.fk.filtered.elementsEqual("dateAsc"){
                            Title(myTitle: "Les plus anciens propos")
                        }
                        HStack{
                            NavigationLink(destination : { AddProposition() }() ){
                                SymbolGenerator(mySymbol :"plus.square.fill", myColor: "pink")
                                Text("Ajouter").foregroundColor(.black).bold()
                            }
                        }
                        //Requête à envoyer selon le filtre
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
