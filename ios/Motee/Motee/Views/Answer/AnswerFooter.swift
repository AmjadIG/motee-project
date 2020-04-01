//
//  AnswerFooter.swift
//  Motee
//
//  Created by Amjad Menouer on 10/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct AnswerFooter: View {
    @State var isNotHide :Bool = false
    @Binding var answer : Answer
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        VStack{
            HStack {
                Spacer()
                AnswerLiked(answer: $answer)
                Spacer()
                if (self.fk.currentUser?.idUser == answer.owner){
                    Button(action : {
                        if AnswerModel.deleteAnswer(idAns: self.answer.idPublication, token: self.fk.token){
                            self.fk.currentPage = ""
                                self.fk.currentPage = "Mes réponses"
                            print("Answer supprimé")
                        }else{
                            print("Answer pas supprimé")
                        }
                    }){
                        Image( systemName: "trash").foregroundColor(Color.red)
                    }
                }else{
                    ReportAnswer(answer: $answer)
                }
                Spacer()
            }.padding()
        }
    }
}
/*
 struct AnswerFooter_Previews: PreviewProvider {
 static var previews: some View {
 AnswerFooter()
 }
 }
 */
