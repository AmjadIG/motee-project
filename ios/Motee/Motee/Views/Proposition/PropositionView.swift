//
//  PropositionView.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionView : View {
    @EnvironmentObject var fk : FilterKit
    @Binding var proposition : Proposition
    @State var showBestAnswer = false
    @State var showAllAnswers = false
    @State var colorIfClicked = generateColor(name: "white")
    @State var colorIfClicked2 = generateColor(name: "black")
    @State var editing = false
    @State var editProposition = ""
    @State var editAnonymous = false
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text(UserModel.getUserById(idUser: proposition.owner).pseudo).bold().foregroundColor(colorIfClicked2)
                    Spacer()
                    Text(getGoodDate(wrongD: proposition.datePublication))
                        .bold()
                        .foregroundColor(colorIfClicked2)
                }.padding().background(colorIfClicked)
                
                if editing {
                    FieldGenerator.plain(label: "",field: "Ecrivez votre propos", text: $editProposition)
                }else{
                    Text(proposition.contentPub).padding(.top, 30.0).padding(.horizontal)
                }
                PropositionFooter(proposition: $proposition, editing: $editing, editProposition: $editProposition, editAnonymous: $editAnonymous).padding()
                
            }.frame(alignment: .leading)
                .edgesIgnoringSafeArea(.all)
                .background(lightGreyColor)
                .cornerRadius(20).shadow(radius: 20)
                .padding()
            
            AnswersPropsView(proposition: $proposition, showBestAnswer: $showBestAnswer, showAllAnswers: $showAllAnswers, colorIfClicked: $colorIfClicked, colorIfClicked2: $colorIfClicked2)
        }
    }
}

struct PropositionView_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAll()[1]
    static var previews: some View {
        PropositionView(proposition: $proposition).environmentObject(FilterKit())
        
    }
}
 
