//
//  ReportAnswer.swift
//  Motee
//
//  Created by user164568 on 3/30/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ReportAnswer: View {
    @EnvironmentObject var fk : FilterKit
    @Binding var answer : Answer
    var body: some View {
        Button(action:{
            self.fk.showAnswerReport = true
            self.fk.answerReported = self.answer
        }){
            Image(systemName: "exclamationmark.triangle").padding(7)
                .foregroundColor(.white)
                .shadow(radius: 0.5)
                .background(Color.red).cornerRadius(40)
        }
    }
}
