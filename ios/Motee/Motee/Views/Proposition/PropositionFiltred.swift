//
//  PropositionFiltred.swift
//  Motee
//
//  Created by user165102 on 3/23/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionFiltred : View {
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    @EnvironmentObject var fk : FilterKit
    @State var filteredProps : [Proposition] = getPropositionFiltered()
    var body: some View {
        VStack{
            forEach(filteredProps){ prop in
                PropositionView(proposition: prop)
            }
        }
    }
}
