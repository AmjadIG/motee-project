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
    var proposition : Proposition
    let dateFormatter = DateFormatter()
    
    @State var showAnswers = false
    @State var colorIfClicked = "white"
    @State var colorIfClicked2 = "black"
    
    //utiliser un objet Proposition
    init(proposition : Proposition){
        self.proposition = proposition
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    func toggleColor(){
        if showAnswers{
            colorIfClicked = "black"
            colorIfClicked2 = "white"
        }else{
            colorIfClicked = "white"
            colorIfClicked2 = "black"

        }
    }
    
    func getDate() -> String {
        //return dateFormatter.string(from: proposition.datePublication)
        return proposition.datePublication
    }
    
    func getLike() -> String {
        return String(proposition.idLikesProp.count)
    }
    
    var body: some View {
        //NavigationView{
            VStack{
            VStack{
                HStack{
                    Text("Pseudo").bold().foregroundColor(generateColor(name: self.colorIfClicked2))
                    Spacer()
                    Text(getDate()).bold().foregroundColor(generateColor(name: self.colorIfClicked2))
                }.padding()
                    .padding(.horizontal).background(generateColor(name: self.colorIfClicked))
            Spacer()
                Text(proposition.contentPub)
                    .padding(.horizontal)
            Spacer()
                PropositionFooter(proposition: proposition).padding()
                Button(
                    action : {
                        self.showAnswers.toggle()
                        self.toggleColor()
                    }){
                       Text("Voir la meilleure réponse")
                }
                Spacer()
                
                }.frame(maxWidth: 380, maxHeight : 220 , alignment: .leading).edgesIgnoringSafeArea(.all)
            .background(lightGreyColor)
            .cornerRadius(20).shadow(radius: 20)
            .padding()
            if (showAnswers){
                ListAnswersView(proposition: proposition)
            }
        }
        //}
    }
}
/*
struct PropositionView_Previews: PreviewProvider {
    static var previews: some View {
        PropositionView()
    }
}
*/
