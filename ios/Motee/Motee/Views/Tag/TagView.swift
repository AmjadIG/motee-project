//
//  TagView.swift
//  Motee
//
//  Created by user165102 on 3/12/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct TagView: View {
    @EnvironmentObject var fk : FilterKit
    @Binding var tag : Tag
    var color : String
    var body : some View {
        
        VStack{
            Text(" #\(tag.label) ")
                .bold()
                .padding()
                .background(generateColor(name: color))
                .cornerRadius(5)
                .foregroundColor(Color.white)
        }.lineLimit(1)
    }
}

struct TagView_Previews: PreviewProvider {
    @State static var tag = Tag(label: "Humour")
    @State static var color = "red"
    static var previews: some View {
        TagView(tag: $tag, color : color).environmentObject(FilterKit())
    }
}

