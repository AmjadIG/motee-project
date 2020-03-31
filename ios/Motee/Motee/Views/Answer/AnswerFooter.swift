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
    @State var answer : Answer
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        VStack{
            HStack {
                Spacer()
                AnswerLiked(answer: answer)
                Spacer()
                if (self.fk.currentUser?.idUser == answer.owner){
                    Button(action : {
                        if AnswerModel.deleteAnswer(idAns: self.answer.idPublication, token: self.fk.token){
                            print("Answer supprimé")
                        }
                    }){
                        SymbolGenerator(mySymbol: "trash", myColor: "red")
                    }
                }else{
                    ReportAnswer(answer: $answer)
                }
                Spacer()
            }
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
