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
    @Binding var proposition : Proposition
    @State var showBestAnswer = false
    @State var showAllAnswers = false
    @State var colorIfClicked = generateColor(name: "white")
    @State var colorIfClicked2 = generateColor(name: "black")
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text(UserModel.getUserById(idUser: proposition.owner).pseudo).bold().foregroundColor(colorIfClicked2)
                    Spacer()
                    Text(proposition.datePublication)
                        .bold()
                        .foregroundColor(colorIfClicked2)
                }.padding().background(colorIfClicked)
                
                Text(proposition.contentPub).padding(.top, 30.0).padding(.horizontal)
                
                PropositionFooter(proposition: $proposition).padding()
                
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
    @State static var proposition = PropositionModel.getAllProps()[2]
 static var previews: some View {
    PropositionView(proposition: $proposition)
 }
 }
 
