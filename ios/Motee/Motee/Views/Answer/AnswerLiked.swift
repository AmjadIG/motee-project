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
            //if the user already liked the answer we can dislike
            if self.answer.estLikee(utilisateur: self.fk.currentUser){
                self.answer.disliker(userDislike: self.fk.currentUser!)
                // if the querry to dislike the answer worked
                if AnswerModel.dislikeAns(idAnswer: self.answer.idPublication, token: self.fk.token){
                    self.fk.currentPage = self.fk.currentPage
                    print("Answer disliked")
                }else{
                    print("Error answer not disliked")
                }
            }
                // the user can like the answer
            else{
                self.answer.liker(userLike: self.fk.currentUser!)
                if AnswerModel.likeAns(idAnswer: self.answer.idPublication, token: self.fk.token){
                    self.fk.currentPage = self.fk.currentPage
                    print("Answer liked")
                }else{
                    print("error Answer not liked")
                }
            }
        }){
            HStack{
                if self.answer.estLikee(utilisateur: fk.currentUser){
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
