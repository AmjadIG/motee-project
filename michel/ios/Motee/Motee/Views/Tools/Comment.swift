//
//  Comment.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct Comment: View {
    @State var isNotHide = false
    @State var comment = ""
    var body: some View {
        VStack{
            VStack{
            Button(action:{
                self.isNotHide.toggle()
            }){
                
                HStack{
                    Text("Commenter")
                    Image(systemName: "message.fill")
                }
                .padding(7)
                .foregroundColor(.white)
                .background(Color.blue).cornerRadius(40)
            }
        }
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
    static var previews: some View {
        Comment()
    }
}
