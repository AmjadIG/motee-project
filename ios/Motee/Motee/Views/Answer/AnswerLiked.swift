//
//  AnswerLiked.swift
//  Motee
//
//  Created by Amjad Menouer on 11/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AnswerLiked : View {
    var answer : Answer
    @EnvironmentObject var fk : FilterKit
    init(answer : Answer){
        self.answer = answer
    }
    
    var body: some View {
        Button(action:{
            if self.answer.estLikee(utilisateur: self.fk.currentUSer){
                self.answer.disliker(userDislike: self.fk.currentUSer!)
            }else{
                self.answer.liker(userLike: self.fk.currentUSer!)
            }
        }){
            HStack{
                if self.answer.estLikee(utilisateur: self.fk.currentUSer){
                    Image(systemName: "heart.fill").foregroundColor(Color.red)
                } else {
                    Image(systemName: "heart").foregroundColor(Color.pink)
                }
                Text(String(answer.idLikesAnswer.count)).foregroundColor(.pink)
            }
        }
    }
}
/*
struct AnswerLiked_Previews: PreviewProvider {
    static var previews: some View {
        AnswerLiked()
    }
}
*/
