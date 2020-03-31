//
//  TrailingNavbar.swift
//  Motee
//
//  Created by user165102 on 3/11/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct TrailingNavbar : View {
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        ZStack{
                if(fk.currentPage == "Accueil"){
                    Button(action: { self.fk.showFilters = true}) {
                        SymbolGenerator(mySymbol: "line.horizontal.3.decrease.circle.fill", myColor: "pink")
                    }
                }else if fk.currentUser == nil {
                    Button(action: { self.fk.currentPage = "Se connecter"}) {
                            SymbolGenerator(mySymbol: "person", myColor: "pink")
                        }
                    }
                    else{
                    Button(action: { self.fk.currentPage = "Compte"}) {
                        SymbolGenerator(mySymbol: "person", myColor: "orange")
                    }
                }
            
        }
    }
}
