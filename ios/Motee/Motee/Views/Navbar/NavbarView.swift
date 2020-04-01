//
//  NavbarView.swift
//  Motee
//
//  Created by Rayan Bahroun on 07/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct NavbarView: View {
    
    @State var showMenu = false
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            if self.fk.showFilters {
                Filter()
            }
            if self.fk.showPropositionReport {
                ReportPropositionView()
            }
            if self.fk.showAnswerReport {
                ReportAnswerView()
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Root()
                    if self.showMenu {
                        MenuView(showMenu: self.$showMenu)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }//.gesture(drag)
                .edgesIgnoringSafeArea(.all)
            }
            .navigationBarTitle(Text(self.fk.currentPage), displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    SymbolGenerator(mySymbol: "line.horizontal.3", myColor: "black")
                        .imageScale(.large)
                })
                , trailing :
                TrailingNavbar()
            )
            
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView().environmentObject(FilterKit())
    }
}
