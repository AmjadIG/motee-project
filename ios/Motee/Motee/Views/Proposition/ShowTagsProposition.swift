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
            ForEach(proposition.tags,id: \.self){oneTag in
                Text(" #\(oneTag) ").bold().background(Color.blue).foregroundColor(Color.white)
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
