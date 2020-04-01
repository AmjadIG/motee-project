//
//  MyAnswers.swift
//  Motee
//
//  Created by Rayan Bahroun on 3/31/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct MyAnswers: View {
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        let answers : [Answer] = UserModel.getAnswersByUser(user: fk.currentUser!)
        return NavigationView{
            ScrollView(.vertical){
                VStack{
                    if answers.count == 0 {
                        Text("Aucune contribution pour le moment").padding()
                        Button( action : {
                            self.fk.currentPage = "Ajouter propos"
                        }){
                            Text("Je contribue tout de suite!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: 320, height: 60)
                            .background(generateColor(name: "orange"))
                            .cornerRadius(40)
                        }.padding()
                    }else{
                        ForEach(answers.indices){ index in
                            AnswerView(answer: answers[index])
                        }
                    }
                }.padding(.top, 80)
            }
        }
    }
}
