//
//  AnswerPropsView.swift
//  Motee
//
//  Created by user165102 on 3/24/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AnswersPropsView : View {
    @Binding var proposition : Proposition
    @Binding var showBestAnswer : Bool
    @Binding var showAllAnswers : Bool
    @Binding var colorIfClicked : Color
    @Binding var colorIfClicked2 : Color
    
    var body: some View {
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
        guard let bestAnswer = PropositionModel.getBestAnswer(proposition: proposition) else {
            return AnyView(VStack {
                Text("Il n'existe pas encore de réponse à afficher")
            })
        }
        return AnyView(VStack{
            Button(action : {
                self.showBestAnswer.toggle()
                self.toggleColor()
            }){
                if (showBestAnswer){
                    Text("Cacher la meilleure réponse").padding([.leading, .bottom, .trailing])
                }
                if(!showAllAnswers && !showBestAnswer){
                    Text("Afficher la meilleure réponse").padding([.leading, .bottom, .trailing])
                }
            }.foregroundColor(Color.pink)
                if (showBestAnswer){
                    AnswerView(answer: bestAnswer)
                    Button(action : {
                        self.showBestAnswer = false
                        self.showAllAnswers.toggle()
                    }){
                        Text("Afficher toutes les réponses").padding([.leading, .bottom, .trailing]).foregroundColor(Color.pink)
                    }

                }
                if (showAllAnswers){
                    ListAnswersView(proposition: $proposition)
                    Button(action : {
                        self.showAllAnswers.toggle()
                        self.toggleColor()
                    }){
                        Text("Cacher toutes les réponses").padding([.leading, .bottom, .trailing]).foregroundColor(Color.pink)
                    }
                }
            }.onTapGesture { }
                .gesture(drag)
            )
        }
    
    func toggleColor(){
        if showBestAnswer{
            colorIfClicked =  Color.blue.opacity(0.5)
            colorIfClicked2 = generateColor(name: "white")
        }else{
            colorIfClicked = generateColor(name: "white")
            colorIfClicked2 = generateColor(name: "black")
            
        }
    }
}

struct AnswersPropsView_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getPropositionById(idProp: "5e7b5c4c7cbb262ef84ab040")
    @State static var showBestAnswer = false
    @State static var showAllAnswers = false
    @State static var colorIfCliked = Color.black
    @State static var colorIfClicked2 = Color.white
    static var previews: some View {
        AnswersPropsView(proposition: $proposition, showBestAnswer: $showBestAnswer, showAllAnswers: $showAllAnswers, colorIfClicked: $colorIfCliked, colorIfClicked2: $colorIfClicked2).environmentObject(FilterKit())
        
    }
}
