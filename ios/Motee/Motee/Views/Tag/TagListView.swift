//
//  TagListView.swift
//  Motee
//
//  Created by user165102 on 3/19/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI


struct TagListView: View {
    @Binding var tagList : [Tag]
    var body: some View {
        HStack{
            ForEach(tagList,id: \.label){oneTag in
                Text(" #\(oneTag.label) ").bold().background(Color.pink).cornerRadius(5).foregroundColor(Color.white)
            }
            Button(action: {
                self.tagList.removeAll()
            }){
                Image(systemName: "trash")
                    .font(.title)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct TagListView_Previews: PreviewProvider {
     @State static var listTag : [Tag] = [Tag(label: "tag1"),Tag(label: "tag2"),Tag(label: "tag3")]
    static var previews: some View {
        TagListView(tagList: $listTag)
    }
}

