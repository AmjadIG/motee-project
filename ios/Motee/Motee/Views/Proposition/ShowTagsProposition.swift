//
//  ShowTagsProposition.swift
//  Motee
//
//  Created by user165102 on 3/22/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ShowTagsProposition: View {
    var proposition : Proposition
    
    init(proposition : Proposition){
        self.proposition = proposition
    }
    
    var body: some View {
        HStack{
            Spacer()
            ForEach(PropositionModel.getAllTags(proposition: proposition),id: \.id){oneTag in
                Text(" #\(oneTag.label) ").bold().background(Color.blue).cornerRadius(CGFloat(5)).foregroundColor(Color.white)
            }
        }.padding([.top, .leading, .trailing])
    }
}
/*
struct ShowTagsProposition_Previews: PreviewProvider {
    @State static var proposition = getProposition()
    static var previews: some View {
        ShowTagsProposition(proposition:  $proposition)
    }
}
*/
