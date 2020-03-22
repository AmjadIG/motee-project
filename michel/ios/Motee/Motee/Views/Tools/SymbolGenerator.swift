//
//  SymbolGenerator.swift
//  Motee
//
//  Created by Rayan Bahroun on 03/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct SymbolGenerator : View {
    var mySymbol : String
    var myColor : String
    
    var body: some View {
        Image(systemName: mySymbol)
            .font(.largeTitle)
            .foregroundColor(generateSymbolColor(name: myColor))
    }
}

func generateSymbolColor(name : String) -> Color {
    switch name {
    case "blue" :
        return .blue
    case "red" :
        return .red
    case "green" :
        return .green
    case "gray" :
        return .gray
    case "orange" :
        return .orange
    case "black" :
        return .black
        
    default:
        return Color.pink
    }
}

struct SymbolGenerator_Previews: PreviewProvider {
    @State static var text = "text.badge.plus"
    @State static var color = "blue"
    static var previews: some View {
        SymbolGenerator(mySymbol: text, myColor: color)
    }
}
