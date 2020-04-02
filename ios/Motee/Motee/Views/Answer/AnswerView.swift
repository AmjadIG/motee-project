//
//  AffichageAnswer.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AnswerView: View {
    @EnvironmentObject var fk : FilterKit
    @State var answer : Answer
    
    var body: some View {
        VStack{
            AnswerHeader(answer: $answer)
            ShowTagAnswer(answer: $answer).padding()
            Text(answer.contentPub).foregroundColor(.white).padding([.leading, .bottom, .trailing])
            AnswerFooter(answer: $answer)
        }.frame(alignment: .leading)
            .background(LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .leading, endPoint: .trailing).opacity(0.8))
            .cornerRadius(20).shadow(radius: 20)
            .padding(.leading, 30.0)
            .padding([.top, .trailing])
    }
}

struct AnswerView_Previews: PreviewProvider {
    @State static var answer = AnswerModel.getAll()[2]
    static var previews: some View {
        AnswerView(answer: answer).environmentObject(FilterKit())
    }
}
