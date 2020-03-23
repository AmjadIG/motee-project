//
//  PropositionView.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionView : View {
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    @Binding var proposition : Proposition// A CHANGER ET A PASSER LA VRAIE PROP EN PARAM DANS LA VIEW SUPERIEURE
    @State var showBestAnswer = false
    @State var showAllAnswers = false
    @State var colorIfClicked = generateColor(name: "white")
    @State var colorIfClicked2 = generateColor(name: "black")
    @State var bestAnswer : Answer = getBestAnswer()
    @State var allAnswers : [Answer] = getAllAnswers()
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
        return
            VStack{
                ShowTagsProposition(proposition: $proposition)
                VStack{
                    HStack{
                        Text(proposition.owner.pseudo).bold().foregroundColor(colorIfClicked2)
                        Spacer()
                        Text(proposition.dateToString())
                            .bold()
                            .foregroundColor(colorIfClicked2)
                    }.padding().background(colorIfClicked)
                    
                    Text(proposition.contentPub).padding(.top, 30.0).padding(.horizontal)
                    
                    PropositionFooter(proposition: proposition).padding()
                    
                }.frame(alignment: .leading)
                    .edgesIgnoringSafeArea(.all)
                    .background(lightGreyColor)
                    .cornerRadius(20).shadow(radius: 20)
                    .padding([.leading, .bottom, .trailing])
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
                VStack{
                    if (showBestAnswer){
                        AnswerView(answer: $bestAnswer)
                        Button(action : {
                            self.showBestAnswer = false
                            self.showAllAnswers.toggle()
                        }){
                            Text("Afficher toutes les réponses")
                        }
                    }
                    if (showAllAnswers){
                        AnswerView()
                        AnswerView()
                        Button(action : {
                            self.showAllAnswers.toggle()
                            self.toggleColor()
                        }){
                            Text("Cacher toutes les réponses")
                        }
                    }
                }.onTapGesture { }
                .gesture(drag)
                ////////////////////////////////////// ///
                /// REQUETE A ENVOYER pour recupere la meilleure reponse ///
                /// ////////////////////////////// ///
                
            }
        
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
/*
func getProposition() -> Proposition {
    let contentProp = "Ceci est un propos test test test test :)"
    let tags = [Tag(label: "tag1"),Tag(label: "tag2")]
    return Proposition(userP: "Niska", identifierP: 1, contentP: contentProp, anonymousP: false, tagsP: tags, titleP: "titre",dateP: Date())
}


struct PropositionView_Previews: PreviewProvider {
    static var previews: some View {
        PropositionView()
    }
}
*/
