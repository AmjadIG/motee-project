//
//  TrailingNavbar.swift
//  Motee
//
//  Created by user165102 on 3/11/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct TrailingNavbar : View {
    @Binding var currentPage : String
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        ZStack{
            if(currentPage == "Accueil"){
                Button(action: { self.fk.showFilters = true}) {
                    SymbolGenerator(mySymbol: "line.horizontal.3.decrease.circle.fill", myColor: "pink")
                }
            }else{
                SymbolGenerator(mySymbol: "person", myColor: "blue")
            }
        }
    }
}
