//
//  MyProps.swift
//  Motee
//
//  Created by Rayan Bahroun on 3/31/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct MyProps: View {
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        let props : [Proposition] = UserModel.getPropsByUserId(idUser: fk.currentUser!.idUser)
        return NavigationView{
            ScrollView(.vertical){
                VStack{
                    if props.count == 0 || props[0] == nil{
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
                        ForEach(props.indices){ index in
                            PropositionView(proposition: props[index])
                        }
                    }
                }.padding(.top, 80)
            }
        }
    }
}
