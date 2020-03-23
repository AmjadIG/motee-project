//
//  topTags.swift
//  Motee
//
//  Created by user165102 on 3/22/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct TopTags : View {
    @State var topTags = getTopTags()
    var body : some View {
        VStack{
            Title(myTitle: "Les meilleurs tags :")
            HStack{
                TagView(tag: $topTags[0], color: "red")
                TagView(tag: $topTags[1], color: "green")
                TagView(tag: $topTags[2], color: "blue")
            }
            HStack{
                TagView(tag: $topTags[3], color: "orange")
                TagView(tag: $topTags[4], color: "purple")
                TagView(tag: $topTags[5], color: "pink")
            }.padding()
            HStack{
                TagView(tag: $topTags[6], color: "yellow")
                TagView(tag: $topTags[7], color: "gray")
                TagView(tag: $topTags[8], color: "black")
            }
        }
    }
}

struct TopTags_Previews: PreviewProvider {
    static var previews: some View {
        TopTags()
    }
}
