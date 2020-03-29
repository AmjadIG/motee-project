//
//  ListeAnswers.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import SwiftUI

struct ListAnswersView: View {
    @EnvironmentObject var fk : FilterKit
    @Binding var proposition : Proposition
    
    var body: some View {
        VStack{
            ForEach(PropositionModel.getAllAnswer(proposition: proposition)){ answr in
                AnswerView(answer: answr)
            }
        }
    }
}

struct ListAnswersView_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAll()[1]
    static var previews: some View {
        ListAnswersView(proposition: $proposition).environmentObject(FilterKit())
    }
}
