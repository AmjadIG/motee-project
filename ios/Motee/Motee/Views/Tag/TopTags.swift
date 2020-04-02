//
//  topTags.swift
//  Motee
//
//  Created by user165102 on 3/22/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct TopTags : View {
    var body : some View {
        let topTags = TagModel.getTop9Tags()
        let pinky = LinearGradient(gradient: Gradient(colors: [.red, .pink]), startPoint: .leading, endPoint: .trailing)
        let mango = LinearGradient(gradient: Gradient(colors: [.pink, .yellow]), startPoint: .leading, endPoint: .trailing)
        let juicy = LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .leading, endPoint: .trailing)
        let honey = LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .leading, endPoint: .trailing)
        return VStack{
            Title(myTitle: "Les tags les plus utilisés :")
            HStack{
                TagView(tag: topTags[0], color: mango) //First problem after cleaning database => No Top tags
                TagView(tag: topTags[1], color: honey)
                TagView(tag: topTags[2], color: juicy)
            }
            HStack{
                TagView(tag: topTags[3], color: pinky)
                TagView(tag: topTags[4], color: mango)
                TagView(tag: topTags[5], color: honey)
            }.padding()
            HStack{
                TagView(tag: topTags[6], color: juicy)
                TagView(tag: topTags[7], color: pinky)
                TagView(tag: topTags[8], color: mango)
            }
        }
    }
}

struct TopTags_Previews: PreviewProvider {
    static var previews: some View {
        TopTags()
    }
}
