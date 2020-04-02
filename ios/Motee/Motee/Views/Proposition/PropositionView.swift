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
    @State var proposition : Proposition
    @State var showBestAnswer = false
    @State var showAllAnswers = false
    @State var colorIfClicked = generateColor(name: "white")
    @State var colorIfClicked2 = generateColor(name: "black")
    var body: some View {
        VStack{
            if proposition.owner != nil {
            VStack(alignment: .center){
                PropositionHeader(proposition: $proposition, colorIfClicked: $colorIfClicked, colorIfClicked2: $colorIfClicked2)
                PropositionTagsView(proposition: $proposition).padding(.vertical,1)
                Text(proposition.title).bold().underline().padding(.horizontal).padding(.top,5)
                Text(proposition.contentPub).padding(.top, 10).padding(.horizontal)
                PropositionFooter(proposition: $proposition).padding(.horizontal)
            }.frame(alignment: .leading)
                .background(lightGreyColor)
                .cornerRadius(20).shadow(radius: 5)
                .padding([.top, .leading, .trailing])
        
            AnswersPropsView(proposition: $proposition, showBestAnswer: $showBestAnswer, showAllAnswers: $showAllAnswers, colorIfClicked: $colorIfClicked, colorIfClicked2: $colorIfClicked2)
            }else{
                Text("Chargement")
            }
        }
    }
}

struct PropositionView_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAll()[1]
    static var previews: some View {
        PropositionView(proposition: proposition).environmentObject(FilterKit())
        
    }
}

