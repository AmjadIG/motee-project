//
//  AnswerHeader.swift
//  Motee
//
//  Created by Rayan Bahroun on 4/1/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AnswerHeader: View {
    @EnvironmentObject var fk : FilterKit
    @Binding var answer : Answer
    
    var body: some View {
        HStack{
            if answer.anonymous {
                Text("Anonyme").bold().foregroundColor(.white)
            }else{
                Text(UserModel.getUserById(idUser: answer.owner ).pseudo).bold().foregroundColor(.white)
            }
            if(self.answer.owner == fk.currentUser?.idUser){
                if answer.anonymous{
                    Button(action:{
                        self.answer.anonymous = false
                        if AnswerModel.updateAns(idAns: self.answer.idPublication, isAnonymous: self.answer.anonymous, ownerAnswer : self.answer.owner, token: self.fk.token) {
                            self.fk.currentPage = self.fk.currentPage
                            print("Answer updated")
                        }
                    }){
                        Image(systemName: "xmark.shield")
                    }
                }else{
                    Button(action:{
                        self.answer.anonymous = true
                        if AnswerModel.updateAns(idAns: self.answer.idPublication, isAnonymous: self.answer.anonymous, ownerAnswer : self.answer.owner, token: self.fk.token) {
                            self.fk.currentPage = self.fk.currentPage
                            print("Answer updated")
                        }
                    }){
                        Image(systemName: "lock.shield.fill")
                    }
                }
            }
            Spacer()
            Text(getGoodDate(wrongD: answer.datePublication)).bold().foregroundColor(.white)
        }.padding()
    }
}

