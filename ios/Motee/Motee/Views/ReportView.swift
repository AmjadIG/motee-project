//
//  ReportView.swift
//  Motee
//
//  Created by user164568 on 3/29/20.
//  Copyright © 2020 groupe3. All rights reserved.
//


import SwiftUI

struct ReportView: View {
    @EnvironmentObject var fk : FilterKit
    var body : some View {
        guard let propReported = fk.propositionReported else {
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
                Text("Vous signalez actuellement : \(UserModel.getUserById(idUser: propReported.owner).pseudo)")
                Text("Rappel de ses propos : ")
                Text("'' \(propReported.contentPub) ''").padding()
                HStack{
                    Button(action: {self.fk.showReport = false ; self.fk.propositionReported = nil}) {
                        Text("Annuler")
                            .bold()
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(lightGreyColor)
                            .foregroundColor(Color.black)
                    }
                    Button(action: {
                        self.fk.showFilters = false
                        
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
            .frame(alignment: .leading)
            .background(Color.white)
            .cornerRadius(20).shadow(radius: 5)
            }.padding()
        })
    }
}


struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView().environmentObject(FilterKit())
    }
}

