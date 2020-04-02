//
//  LoginBanner.swift
//  Motee
//
//  Created by user164568 on 3/24/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct LoginBanner: View {
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        VStack{
            if(self.fk.currentUser == nil){
                HStack(){
                    Spacer()
                    Button(action : {
                        self.fk.currentPage = "Se connecter"
                    }){
                    Text("Connectez-vous pour profiter de toutes les fonctionnalités !")
                        .bold()
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.all, 0.0)
                    }
                    Spacer()
                }.background(Color.pink)
                    
            }
        }.padding(.top,72)
    }
}

struct LoginBanner_Previews: PreviewProvider {
    static var previews: some View {
        LoginBanner().environmentObject(FilterKit())
    }
}
