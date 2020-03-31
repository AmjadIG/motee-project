//
//  SearchBar.swift
//  Motee
//
//  Created by Amjad Menouer on 28/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @State var textSearch : String = ""
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        HStack{
            TextField("Recherche ...", text: $textSearch).padding([.top, .leading, .bottom], 10.0)
            .background(lightGreyColor)
            .cornerRadius(5.0)
            Button(action:{
                self.fk.textSearch = self.textSearch
            }){
                SymbolGenerator(mySymbol: "magnifyingglass.circle.fill", myColor: "orange").padding(5)
            }
            }.padding()
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
