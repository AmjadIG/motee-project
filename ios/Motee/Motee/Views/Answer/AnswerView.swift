//
//  AffichageAnswer.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import SwiftUI
import UserNotifications

struct AnswerView: View {
    
    var answer : Answer
    let dateFormatter = DateFormatter()
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
        
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text(UserModel.getUserById(idUser: answer.owner ).pseudo).bold().foregroundColor(.white)
                    Spacer()
                    Text(answer.datePublication).bold().foregroundColor(.white)
                }.padding()
                    .padding(.horizontal)
            Spacer()
                Text(answer.contentPub).foregroundColor(.white)
                    .padding(.horizontal)
            Spacer()
                
                if (currentUser != nil){
                    AnswerFooter(answer: answer)
                    Spacer()
                }
                
                }.frame(alignment: .leading).edgesIgnoringSafeArea(.all)
                .background(Color.blue.opacity(0.5))
            .cornerRadius(20).shadow(radius: 20)
                .padding(.leading, 30.0)
            .padding()
        }
    }
}
/*
struct AnswerView_Previews: PreviewProvider {
    @State static var answer = AnswerModel.getAll()[]
    static var previews: some View {
        AnswerView(answer: $answer)
    }
}
 */
