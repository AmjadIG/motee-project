//
//  ReportAnswerView.swift
//  Motee
//
//  Created by user164568 on 3/30/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ReportAnswerView: View {
    @EnvironmentObject var fk : FilterKit
    var body : some View {
        guard let ansReported = fk.answerReported else {
            return AnyView(ZStack {
                Color.black.opacity(0.1).edgesIgnoringSafeArea(.vertical)
                VStack(spacing: 20) {
                    Text("Signalement")
                        .bold()
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                    Text("Impossible de récupérer la publication à signaler").padding()
                }.frame(alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(20).shadow(radius: 20)
            })
        }
        return AnyView(ZStack {
            Color.black.opacity(0.4) .edgesIgnoringSafeArea(.vertical)
            HStack{
            VStack(spacing: 20) {
                Text("Signalement")
                    .bold()
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                Text("Vous signalez actuellement : \(UserModel.getUserById(idUser: ansReported.owner).pseudo)")
                Text("Rappel de ses propos : ")
                Text("'' \(ansReported.contentPub) ''").padding()
                if (self.fk.answerReported?.idReport.contains(self.fk.currentUser!.idUser))! {
                    Text("Vous avez déjà signalé cette proposition")
                }
                HStack{
                    Button(action: {self.fk.showAnswerReport = false ; self.fk.answerReported = nil}) {
                        Text("Annuler")
                            .bold()
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(lightGreyColor)
                            .foregroundColor(Color.black)
                    }
                    if !(self.fk.answerReported?.idReport.contains(self.fk.currentUser!.idUser))! {
                        Button(action: {
                                if AnswerModel.report(idAnswer: self.fk.answerReported!.idPublication, token: self.fk.token){
                                    self.fk.showAnswerReport = false
                                }
                            }) {
                            Text("Envoyer")
                                .bold()
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
            .frame(alignment: .leading)
            .background(Color.white)
            .cornerRadius(20).shadow(radius: 5)
            }.padding()
        })
    }
}


struct ReportAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        ReportPropositionView().environmentObject(FilterKit())
    }
}


