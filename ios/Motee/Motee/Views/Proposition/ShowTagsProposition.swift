//
//  ShowTagsProposition.swift
//  Motee
//
//  Created by user165102 on 3/22/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ShowTagsProposition: View {
    @Binding var proposition : Proposition
    var body: some View {
        HStack{
            Spacer()
            ForEach(proposition.tags,id: \.id){oneTag in
                Text(" #\(oneTag.label) ").bold().background(Color.blue).cornerRadius(5).foregroundColor(Color.white)
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
