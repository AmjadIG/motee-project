//
//  AjoutAnswer.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import SwiftUI

struct AddAnswerView: View {
    @State var newContent : String = ""
    @State var alertEmptyAnswer : Bool = false
    @Binding var propos : Proposition
    
    var user = (UIApplication.shared.delegate as! AppDelegate).currentUser
    
    var body: some View {
        VStack(alignment:HorizontalAlignment.center,spacing: 15){
            if propos.anonymous {
                Text("Répondre à Anonyme").font(.system(size: 18)).bold().foregroundColor(.blue)
            } else {
                //Text("Répondre à \(propos.owner.pseudo)").font(.system(size: 18)).bold().foregroundColor(.blue)
            }
            Text(propos.contentPub).font(.system(size: 18))
            Divider()
            TextField("Ecrivez votre réponse", text: $newContent)
            Divider()
            Button(action: {
                //Ajoute la réponse
                //Renvoie à l'écran d'accueil
                if self.newContent==""{
                    self.alertEmptyAnswer = true
                } else{
                    //
                    self.alertEmptyAnswer = false
                    /*if AnswerDAO.putAnswer(idAnswer: "testId", token: self.newContent){
                        //Renvoie la liste de reponses ensuite
                        
                    }*/
                }
            }){
                Text("Envoyer Réponse").bold().padding(10).foregroundColor(Color.white).background(Color.green).cornerRadius(40)
            }
            Button(action: {
                //Ajoute la réponse
                //Renvoie à l'écran d'accueil
                if self.newContent==""{
                    self.alertEmptyAnswer = true
                } else{
                    //
                    self.alertEmptyAnswer = false
                    /*if AnswerDAO.putAnswer(idAnswer: "testId", token: self.newContent){
                        //Renvoie la liste de reponses ensuite
                    }*/
                }
            }){
                Text("Envoyer Réponse Anonyme").bold().padding(10).foregroundColor(Color.white).background(Color.gray).cornerRadius(40)
            }
            if alertEmptyAnswer {
                Text("Message vide...").foregroundColor(Color.red).padding(5)
            }
        }.padding()
    }
}

struct AddAnswerView_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAll()[0]
    static var previews: some View {
        AddAnswerView(propos: $proposition)
    }
}
