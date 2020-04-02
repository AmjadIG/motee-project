//
//  PublicationFooter.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionFooter : View {
    @EnvironmentObject var fk : FilterKit
    @Binding var proposition : Proposition
    @State var isNotHide :Bool = false
    @State var comment = ""
    @State var selection = ""
    var body: some View {
        VStack{
            VStack{
                HStack {
                    PropositionLiked(proposition: $proposition)
                    Spacer()
                    if(fk.currentUser != nil){
                        Button(action:{
                            self.isNotHide.toggle()
                        }){
                            HStack{
                                Text("Contribuer")
                                Image(systemName: "message.fill")
                            }
                            .padding(7)
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [.yellow, .pink]), startPoint: .leading, endPoint: .trailing)).cornerRadius(20)
                        }
                    }else{
                        HStack{
                            Text("Connexion requise")
                            Image(systemName: "message.fill")
                        }.padding(7)
                            .foregroundColor(.white)
                            .background(Color.gray).cornerRadius(20)
                    }
                    Spacer()
                    
                    if (self.fk.currentUser?.idUser == proposition.owner){
                        Button( action :  {
                            if PropositionModel.deleteProposition(idProp: self.proposition.idPublication, token: self.fk.token){
                                self.fk.currentPage = self.fk.currentPage
                                print("Proposition deleted ")
                            }else{
                                print("Proposition not deleted ")
                            }
                            self.fk.currentPage = self.fk.currentPage
                        }){
                            Image(systemName: "trash.fill").foregroundColor(Color.red).padding()
                        }
                    }else{
                        ReportProposition(proposition: $proposition)
                    }
                }.padding()
            }
            if isNotHide {
                HStack{
                    TextField("Commentaire...", text: $comment).cornerRadius(20)
                    Button(action:{
                        if AnswerModel.addAnswer(contentPub: self.comment, isAnonymous: false, tagsAns: [Tag(label :self.selection)], idProposition: self.proposition.id, token: self.fk.token){
                            print("Answer added")
                            
                        }
                        self.comment = ""
                        self.fk.currentPage = "Mes réponses"
                    }){
                        Image(systemName: "arrowtriangle.right.circle.fill").padding(5).foregroundColor(Color.pink)
                    }
                    
                }.padding()
                Text("Choisir un tag (optionnel) :").padding(.bottom)
                ChooseTag(selection: $selection)
            }
        }.padding()
    }
}

struct PropositionFooter_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAll()[2]
    @State static var editing = false
    @State static var editProposition = ""
    @State static var editAnonymous = false
    static var previews: some View {
        PropositionFooter(proposition: $proposition).environmentObject(FilterKit())
    }
}
