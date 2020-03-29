//
//  PropositionTagsView.swift
//  Motee
//
//  Created by user164568 on 3/28/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionTagsView : View {
    @Binding var proposition : Proposition
    var body: some View {
        HStack {
            Spacer()
            ForEach(proposition.tags,id: \.self){oneTag in
                Text(" #\(TagModel.getTagById(idTag: oneTag).label) ")
                    .bold()
                    .background(Color.pink)
                    .cornerRadius(5)
                    .foregroundColor(Color.white)
            }
        }.padding(.horizontal)
    }
}
