//
//  ShowTagAnswer.swift
//  Motee
//
//  Created by user164568 on 4/2/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ShowTagAnswer : View {
    @Binding var answer : Answer
    var body: some View {
        HStack {
            Spacer()
            ForEach(answer.tagsAnswer,id: \.self){oneTag in
                Text(" #\(TagModel.getTagById(idTag: oneTag).label) ")
                    .bold()
                    .background(Color.white)
                    .cornerRadius(5)
                    .foregroundColor(Color.pink)
            }
        }.padding(.horizontal)
    }
}
