//
//  Filter.swift
//  Motee
//
//  Created by Rayan Bahroun on 04/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct Filter: View {
    @EnvironmentObject var fk : FilterKit
    var body : some View {
        ZStack {
            Color.black.opacity(0.4) .edgesIgnoringSafeArea(.vertical)
            VStack(spacing: 20) {
                Text("Filtre")
                    .bold()
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                Spacer()
                if !fk.filtered.elementsEqual("byLike"){
                    Button(action: { self.fk.filtered = ""; self.fk.showFilters = false}){
                        Text("Aucun filtre").bold().foregroundColor(Color.black)
                    }
                }
                Button(action: { self.fk.filtered = "byLike" ; self.fk.showFilters = false}){
                    Text("Les mieux notés").bold().foregroundColor(Color.black)
                }
                Button(action: { self.fk.filtered = "desc";self.fk.showFilters = false}){
                    Text("Les plus récents").bold().foregroundColor(Color.black)
                }
                Button(action: {self.fk.filtered = "asc";self.fk.showFilters = false}){
                    Text("Les plus anciens").bold().foregroundColor(Color.black)
                }
                Button(action: {self.fk.showFilters = false}) {
                    Text("Quitter")
                        .bold()
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(lightGreyColor)
                        .foregroundColor(Color.black)
                }
            }
            .frame(width: 300, height: 310)
            .background(Color.white)
            .cornerRadius(20).shadow(radius: 20)
        }
    }
}

struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter().environmentObject(FilterKit())
    }
}
