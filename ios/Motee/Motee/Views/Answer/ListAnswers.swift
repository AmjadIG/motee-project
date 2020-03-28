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
    @Binding var proposition : Proposition
    
    var body: some View {
        NavigationView{
            VStack{/*
                if(filter.elementsEqual("all")){
                    Title(myTitle: "Toutes les réponses")
                }else if filter.elementsEqual("like"){
                    Title(myTitle: "Les meilleurs réponses")
                }else if filter.elementsEqual("dateDesc"){
                    Title(myTitle: "Les plus récents réponses")
                }else if filter.elementsEqual("dateAsc"){
                    Title(myTitle: "Les plus anciennes réponses")
                }
                */
                ForEach(PropositionModel.getAllAnswer(proposition: proposition)){ answr in
                    AnswerView(answer: answr)
                }
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
