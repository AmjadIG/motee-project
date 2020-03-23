//
//  TagListView.swift
//  Motee
//
//  Created by user165102 on 3/19/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI


struct TagListView: View {
    @Binding var tagList : [String]
    var body: some View {
        HStack{
            ForEach(tagList,id: \.self){oneTag in
                Text(" #\(oneTag.description) ").bold().background(Color.blue).cornerRadius(5).foregroundColor(Color.white)
            }
            Button(action: {
                self.tagList.removeAll()
            }){
                SymbolGenerator(mySymbol: "trash", myColor: "gray")
            }
        }
    }
}

struct TagListView_Previews: PreviewProvider {
    @State static var list : [String] = ["tag1","tag2","tag3"]
    static var previews: some View {
        TagListView(tagList: $list)
    }
}

