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
    @State var props = PropositionModel.getAllProps()
    var body: some View {
        VStack{
<<<<<<< HEAD
             List{
                ForEach(props.indices){ index in
                    PropositionView(proposition: self.$props[index])
=======
             /*List{
                ForEach(PropositionModel.getAllProps()){ proposition in
                    PropositionView(proposition: proposition)
>>>>>>> 2d9e1e3d27d5a4001008b36c782432a3074d2948
                }
             }*/
            Text("Rayan will do this part")
        }
    }
}
