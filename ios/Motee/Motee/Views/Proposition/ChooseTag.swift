//
//  ChooseTag.swift
//  Motee
//
//  Created by user164568 on 4/2/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ChooseTag : View {
    var possibleTags = ["loi","humour","citation","autre"]
    @Binding var selection : String
    var body: some View {
        HStack{
            ForEach(possibleTags.indices){index in
                Button(action: {
                    if(self.selection.elementsEqual(self.possibleTags[index])){
                        self.selection = ""
                    }else{
                        self.selection = self.possibleTags[index]
                    }
                }){
                    if(self.selection.elementsEqual(self.possibleTags[index])){
                        Text(" #\(self.possibleTags[index]) ")
                        .bold()
                        .background(Color.pink)
                        .cornerRadius(5)
                        .foregroundColor(Color.white)
                            .frame(alignment : .center).padding(1).background(Color.yellow)
                    }else{
                        Text(" #\(self.possibleTags[index]) ")
                        .bold()
                        .background(Color.pink)
                        .cornerRadius(5)
                        .foregroundColor(Color.white)
                    }
                
                }
            }
        }
    }
}
