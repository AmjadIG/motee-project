//
//  AnswerFooter.swift
//  Motee
//
//  Created by Amjad Menouer on 10/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AnswerFooter: View {
    @State var isNotHide :Bool = false
    var answer : Answer
    
    var body: some View {
        VStack{
            VStack{
                HStack {
                    Spacer()
                    AnswerLiked(answer: answer)
                    Spacer()
                    Report()
                    Spacer()
                }
            }
        }.padding()
    }
}
/*
struct AnswerFooter_Previews: PreviewProvider {
    static var previews: some View {
        AnswerFooter()
    }
}
*/
