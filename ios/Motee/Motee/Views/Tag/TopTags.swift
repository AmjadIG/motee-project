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
            if topTags.count>0{
                Title(myTitle: "Tags les plus utilisés :")
            }
            HStack{
                TagView(tags: topTags, index : 0, color: mango)
                TagView(tags: topTags, index : 1, color: honey)
                TagView(tags: topTags, index : 2, color: juicy)
            }
            HStack{
                TagView(tags: topTags, index : 3, color: pinky)
                TagView(tags: topTags, index : 4, color: mango)
                TagView(tags: topTags, index : 5, color: honey)
            }.padding()
            HStack{
                TagView(tags: topTags, index : 6, color: juicy)
                TagView(tags: topTags, index : 7, color: pinky)
                TagView(tags: topTags, index : 8, color: mango)
            }
        }.padding()
    }
}

struct TopTags_Previews: PreviewProvider {
    static var previews: some View {
        TopTags()
    }
}
