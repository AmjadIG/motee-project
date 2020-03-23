//
//  Comment.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct Comment: View {
    @Binding var isNotHide : Bool
    @Binding var comment : String
    var body: some View {
        VStack{
            if isNotHide {
                HStack{
                    TextField("Commentaire...", text: $comment).cornerRadius(40)
                    Button(action:{
                        // TODO
                        //Envoyer le commentaire
                    }){
                        Image(systemName: "arrowtriangle.right.circle.fill").padding(5)
                    }
                }.padding()
            }
        }
    }
}

struct Comment_Previews: PreviewProvider {
    @State static var isNoteHide = true
    @State static var comment = ""
    static var previews: some View {
        Comment(isNotHide: $isNoteHide, comment: $comment)
    }
}
