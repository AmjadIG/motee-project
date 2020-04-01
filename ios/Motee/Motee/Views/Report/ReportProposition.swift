//
//  Report.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct ReportProposition: View {
    @EnvironmentObject var fk : FilterKit
    @Binding var proposition : Proposition
    var body: some View {
        Button(action:{
            if self.fk.currentUser == nil {
                self.fk.currentPage = "Se connecter"
            }else{
                self.fk.showPropositionReport = true
                self.fk.propositionReported = self.proposition
            }
        }){
            Image(systemName: "exclamationmark.triangle.fill").padding(7)
                .foregroundColor(.white)
                .background(Color.red).cornerRadius(40)
        }
    }
}

