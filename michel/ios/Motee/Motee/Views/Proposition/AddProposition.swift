//
//  AddProposition.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AddProposition: View {
    
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    @State var newPropositionContent : String = ""
    @State var newAnswerContent : String = ""
    
    @State var anonymousProposition : Bool = false
    @State var anonymousAnswer : Bool = false

    @State var answerAdding : Bool = false
    
    var body: some View {
        VStack{
            Title(myTitle: "Ajouter un propos")
            Divider()
            ScrollView{
                Text("Votre Propos").font(.system(size: 18)).bold().foregroundColor(.blue).padding()
                TextField("Ecrivez votre propos", text: $newPropositionContent).padding()
                Toggle(isOn : $anonymousProposition){
                    Text("Propos anonyme")
                }
                Divider()
                Toggle(isOn : $answerAdding){
                    Text("Proposer une réponse ?")
                }
                if answerAdding {
                    Text("Votre Reponse").font(.system(size: 18)).bold().foregroundColor(.blue).padding()
                    TextField("Ecrivez votre reponse", text: $newAnswerContent).padding()
                    Toggle(isOn : $anonymousAnswer){
                        Text("Propos anonyme")
                    }
                }
                Divider().padding()
                //Should be replaced by nav link
                Button(action:{
                    //We have to put the Proposition (and the Answer) into the database
                    if self.answerAdding {
                        //AnswerDAO.putAnswer(idAnswer: "", token: "")
                        //PropositionDAO.putProps()
                    } else {
                        //PropositionDAO.putProps()
                    }
                }){
                    Text("Envoyer").bold().padding(15)
                    
                }.foregroundColor(Color.white).background(Color.blue).cornerRadius(40)
            }.padding(20)
        }
    }
}

struct AddProposition_Previews: PreviewProvider {
    static var previews: some View {
        AddProposition()
    }
}
