//
//  SearchBar.swift
//  Motee
//
//  Created by Amjad Menouer on 28/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @State var query : String = ""
    var body: some View {
        HStack{
            TextField("Recherche ...", text: $query, onCommit: fetch).padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            }.onAppear(perform: fetch).padding()
    }
    
    private func fetch(){
        //PropositionModel.fetch(matching: query)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
