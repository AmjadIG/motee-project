//
//  PublicationFooter.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionFooter : View {
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    @Binding var proposition : Proposition
    @State var isNotHide :Bool = false
    @State var comment = ""
    
    var body: some View {
        VStack{
            VStack{
                HStack {
                    PropositionLiked(proposition: $proposition)
                    Spacer()
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
                    Spacer()
                    Report()
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
    static var previews: some View {
        PropositionFooter(proposition: $proposition)
    }
}
