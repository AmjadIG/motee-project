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
        return VStack{
            Title(myTitle: "Les tags les plus utilisés :")
            HStack{
                TagView(tag: topTags[0], color: "pink")
                TagView(tag: topTags[1], color: "yellow")
                TagView(tag: topTags[2], color: "pink")
            }
            HStack{
                TagView(tag: topTags[3], color: "red")
                TagView(tag: topTags[4], color: "orange")
                TagView(tag: topTags[5], color: "red")
            }.padding()
            HStack{
                TagView(tag: topTags[6], color: "orange")
                TagView(tag: topTags[7], color: "yellow")
                TagView(tag: topTags[8], color: "orange")
            }
        }
    }
}

struct TopTags_Previews: PreviewProvider {
    static var previews: some View {
        TopTags()
    }
}
