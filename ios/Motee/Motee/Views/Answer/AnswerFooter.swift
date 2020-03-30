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
    @State var answer : Answer
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                AnswerLiked(answer: answer)
                Spacer()
                ReportAnswer(answer: $answer)
                Spacer()
            }
        }
    }
}
/*
 struct AnswerFooter_Previews: PreviewProvider {
 static var previews: some View {
 AnswerFooter()
 }
 }
 */
