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
    @State var tags : [Tag]
    @State var index : Int
    var color : String
    var body : some View {
        VStack{
            if(tags.count >= index){
            Button(action:{
                if self.containsThisTag(){
                    self.removeTag()
                    self.fk.showFilters = true
                }else{
                    self.fk.tags.append(self.tags[self.index])
                    self.fk.showFilters = true
                }
            }){
                if self.containsThisTag(){
                    VStack{
                        Text(" #\(tags[index].label) ")
                        .bold()
                        .padding()
                        .background(generateColor(name: color))
                        .cornerRadius(5)
                        .foregroundColor(Color.white)
                    }.frame(alignment : .center).padding(3).background(generateColor(name: color).colorInvert())
                }else{
                    Text(" #\(tags[index].label) ")
                    .bold()
                    .padding()
                    .background(generateColor(name: color))
                    .cornerRadius(5)
                    .foregroundColor(Color.white)
                }
            }
            }else{
                Text(" #Indisponible")
                .bold()
                .padding()
                .background(generateColor(name: color))
                .cornerRadius(5)
                .foregroundColor(Color.white)
            }
        }.lineLimit(1)
    }
    func containsThisTag()->Bool {
        var res = false
        for tag in fk.tags {
            if tag.equals(otherTag: tags[index]){
                res = true
            }
        }
        return res
    }
    
    func removeTag(){
        for i in 0..<self.fk.tags.count {
            if self.fk.tags[i].equals(otherTag: tags[index]) {
                self.fk.tags.remove(at: i)
            }
        }
    }
}

struct TagView_Previews: PreviewProvider {
    @State static var tags = [Tag(label: "Humour")]
    @State static var color = "red"
    @State static var index = 0
    static var previews: some View {
        TagView(tags: tags,index : index, color : color).environmentObject(FilterKit())
    }
}

