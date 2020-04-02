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
            if topTags.count>0{
                Title(myTitle: "Les tags les plus utilisés :")
            }
            HStack{
                TagView(tags: topTags, index : 0, color: "pink")
                TagView(tags: topTags, index : 1, color: "yellow")
                TagView(tags: topTags, index : 2, color: "pink")
            }
            HStack{
                TagView(tags: topTags, index : 3, color: "red")
                TagView(tags: topTags, index : 4, color: "orange")
                TagView(tags: topTags, index : 5, color: "red")
            }.padding()
            HStack{
                TagView(tags: topTags, index : 6, color: "orange")
                TagView(tags: topTags, index : 7, color: "yellow")
                TagView(tags: topTags, index : 8, color: "orange")
            }
        }.padding()
    }
}

struct TopTags_Previews: PreviewProvider {
    static var previews: some View {
        TopTags()
    }
}
