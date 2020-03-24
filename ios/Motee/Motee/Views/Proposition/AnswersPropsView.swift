//
//  AnswerPropsView.swift
//  Motee
//
//  Created by user165102 on 3/24/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AnswersPropsView : View {
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    @Binding var proposition : Proposition
    @State var showBestAnswer = false
    @State var showAllAnswers = false
    @State var colorIfClicked = generateColor(name: "white")
    @State var colorIfClicked2 = generateColor(name: "black")
    @State var bestAnswer : Answer?
    var body: some View {
        bestAnswer = getBestAnswer(proposition: proposition)
        
        guard let bestAnswer = bestAnswer else {
            return AnyView(VStack {
                Text("il n'existe pas encore de réponse à afficher")
            })
        }
        return AnyView(VStack{
            Button(action : {
                self.showBestAnswer.toggle()
                self.toggleColor()
            }){
                if (showBestAnswer){
                    Text("Cacher la meilleure réponse")
                }
                if(!showAllAnswers && !showBestAnswer){
                    Text("Afficher la meilleure réponse")
                }
            }
                if (showBestAnswer){
                    AnswerView(answer: bestAnswer)
                    Button(action : {
                        self.showBestAnswer = false
                        self.showAllAnswers.toggle()
                    }){
                        Text("Afficher toutes les réponses")
                    }
                }
                if (showAllAnswers){
                    ListAnswersView(proposition: $proposition)
                    Button(action : {
                        self.showAllAnswers.toggle()
                        self.toggleColor()
                    }){
                        Text("Cacher toutes les réponses")
                    }
                }
            }.onTapGesture { }
                .gesture(drag)
            )
        }
}
