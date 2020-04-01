//
//  AnswerLiked.swift
//  Motee
//
//  Created by Amjad Menouer on 11/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AnswerLiked : View {
    @Binding var answer : Answer
    @EnvironmentObject var fk : FilterKit
    
    var body: some View {
        Button(action:{
            if self.answer.estLikee(utilisateur: self.fk.currentUser){
                self.answer.disliker(userDislike: self.fk.currentUser!)
            }else{
                self.answer.liker(userLike: self.fk.currentUser!)
            }
        }){
            HStack{
                if self.answer.estLikee(utilisateur: self.fk.currentUser){
                    Image(systemName: "heart.fill").foregroundColor(Color.white)
                } else {
                    Image(systemName: "heart").foregroundColor(Color.white)
                }
                Text(String(answer.idLikesAnswer.count)).foregroundColor(.white)
            }
        }
    }
}

struct AnswerLiked_Previews: PreviewProvider {
    @State static var answer = AnswerModel.getAnswerById(idAns: "5e7b696b7cbb262ef84ab053")!
    static var previews: some View {
        AnswerLiked(answer: $answer).environmentObject(FilterKit())
    }
}
