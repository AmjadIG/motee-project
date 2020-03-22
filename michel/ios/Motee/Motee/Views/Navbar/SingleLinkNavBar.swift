//
//  SingleLinkNavBar.swift
//  Motee
//
//  Created by Rayan Bahroun on 08/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI


struct SingleLinkNavBar: View {
    var title : String = "Accueil"
    var symbol : String = "house"
    var topPadding : CGFloat = 100
var body: some View {
    HStack {
        Image(systemName: symbol)
            .foregroundColor(.gray)
            .imageScale(.large)
        Text(title)
            .foregroundColor(.gray)
            .font(.headline)
    }
    .padding(.top, topPadding)
    }
}

struct SingleLinkNavBar_Previews: PreviewProvider {
    @State static var title = "Accueil"
    @State static var symbol = "house"
    @State static var topPadding : CGFloat = 100
    static var previews: some View {
        SingleLinkNavBar(title : title, symbol: symbol, topPadding: topPadding)
    }
}
