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
            Button(action:{
                if self.containsThisTag(){
                    self.removeTag()
                }else{
                    self.fk.tags.append(self.tag)
                }
                self.fk.currentPage = "Accueil"
            }){
                if self.containsThisTag(){
                    VStack{
                        Text(" #\(tag.label) ")
                        .bold()
                        .padding()
                        .background(generateColor(name: color))
                        .cornerRadius(5)
                        .foregroundColor(Color.white)
                    }.frame(alignment : .center).padding(3).background(generateColor(name: color).colorInvert())
                }else{
                    Text(" #\(tag.label) ")
                    .bold()
                    .padding()
                    .background(generateColor(name: color))
                    .cornerRadius(5)
                    .foregroundColor(Color.white)
                }
            }
        }.lineLimit(1)
    }
    func containsThisTag()->Bool {
        var res = false
        for tag in fk.tags {
            if tag.equals(otherTag: self.tag){
                res = true
            }
        }
        return res
    }
    
    func removeTag(){
        for i in 0..<self.fk.tags.count {
            if self.fk.tags[i].equals(otherTag: self.tag) {
                self.fk.tags.remove(at: i)
            }
        }
    }
}

struct TagView_Previews: PreviewProvider {
    @State static var tag = Tag(label: "Humour")
    @State static var color = "red"
    static var previews: some View {
        TagView(tag: $tag, color : color).environmentObject(FilterKit())
    }
}

