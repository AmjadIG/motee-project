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
    var proposition : Proposition
    @Binding var showBestAnswer : Bool
    @Binding var showAllAnswers : Bool
    @Binding var colorIfClicked : Color
    @Binding var colorIfClicked2 : Color
    @State var bestAnswer : Answer?
    var body: some View {
        bestAnswer = PropositionModel.getBestAnswer(proposition: proposition)
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showAllAnswers = false
                        self.showBestAnswer = false
                        self.toggleColor()
                    }
                }
        }
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
                    ListAnswersView(proposition: proposition)
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
    
    func toggleColor(){
        if showBestAnswer{
            colorIfClicked =  Color.blue.opacity(0.7)
            colorIfClicked2 = generateColor(name: "white")
        }else{
            colorIfClicked = generateColor(name: "white")
            colorIfClicked2 = generateColor(name: "black")
            
        }
    }
}
