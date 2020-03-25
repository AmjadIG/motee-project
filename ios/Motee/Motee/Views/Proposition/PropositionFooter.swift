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
    @Binding var editing : Bool
    @Binding var editProposition : String
    @Binding var editAnonymous : Bool
    var body: some View {
        VStack{
            VStack{
                HStack {
                    PropositionLiked(proposition: $proposition)
                    Spacer()
                    if(fk.currentUSer != nil && !editing){
                        Button(action:{
                            self.isNotHide.toggle()
                        }){
                            HStack{
                                Text("Contribuer")
                                Image(systemName: "message.fill")
                            }
                            .padding(7)
                            .foregroundColor(.white)
                            .background(Color.blue).cornerRadius(20)
                        }
                    }else if self.editing{
                        Button(action: {
                            PropositionModel.updateProp(idProp: self.proposition.idPublication, contentProp: self.editProposition, isAnonymous: self.proposition.anonymous, token: self.fk.token)
                            self.editing.toggle()
                        }){
                            HStack{
                                Text("éditer")
                                Image(systemName: "message.fill")
                            }.padding(7)
                                .foregroundColor(.white)
                                .background(Color.green).cornerRadius(20)
                        }
                    }
                    else{
                        HStack{
                            Text("Connexion requise")
                            Image(systemName: "message.fill")
                        }.padding(7)
                            .foregroundColor(.white)
                            .background(Color.gray).cornerRadius(20)
                    }
                    Spacer()
                    
                    if (self.fk.currentUSer?.idUser == proposition.owner){
                        Button(action: {
                            self.editing.toggle()
                            self.editProposition = self.proposition.contentPub
                            self.editAnonymous = self.proposition.anonymous
                        }){
                            SymbolGenerator(mySymbol: "square.and.pencil", myColor: "gray")
                        }
                    }else{
                        Report()
                    }
                }
            }
            if isNotHide {
                HStack{
                    TextField("Commentaire...", text: $comment).cornerRadius(20)
                    Button(action:{
                        // TODO
                        //Envoyer le commentaire
                    }){
                        Image(systemName: "arrowtriangle.right.circle.fill").padding(5)
                    }
                }.padding()
            }
        }.padding()
    }
}

struct PropositionFooter_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAllProps()[2]
    @State static var editing = false
    @State static var editProposition = ""
    @State static var editAnonymous = false
    static var previews: some View {
        PropositionFooter(proposition: $proposition, editing: $editing, editProposition : $editProposition, editAnonymous: $editAnonymous).environmentObject(FilterKit())
    }
}
