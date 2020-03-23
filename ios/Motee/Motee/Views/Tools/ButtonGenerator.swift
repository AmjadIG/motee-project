//
//  ButtonGenerator.swift
//  Motee
//
//  Created by Rayan Bahroun on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ButtonGenerator : View {
    var myText : String
    var myColor : String
    
    var body: some View {
        Text(myText)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(generateColor(name: myColor))
            .cornerRadius(40)
    }
}

func generateColor(name : String) -> Color {
    switch name {
    case "blue" :
        return Color.blue
    case "red" :
        return Color.red
    case "green" :
        return Color.green
    case "gray" :
        return Color.gray
    case "orange" :
        return Color.orange
    case "black" :
        return Color.black
    case "pink" :
        return Color.pink
    case "white" :
        return Color.white
    case "yellow" :
        return Color.yellow
        
    default:
        return Color.purple
    }
    
}

struct ButtonGenerator_Previews: PreviewProvider {
    @State static var text = "S'inscrire"
    @State static var color = "orange"
    static var previews: some View {
        ButtonGenerator(myText: text, myColor: color)
    }
}
