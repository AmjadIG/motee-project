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
    
    @State var props : [Proposition] = PropositionModel.getFilteredProps(filter: "desc",tags: [])
    
    //init(f : String, t : [Tag]) {
    //    _props = State(initialValue: PropositionModel.getFilteredProps(filter: f, tags: t))
    //    }
    var body: some View {
        VStack{
            ForEach(props.indices){ index in
                PropositionView(proposition: self.$props[index])
            }
        }
    }
}
struct PropositionFiltred_Previews: PreviewProvider {
    static var previews: some View {
        PropositionFiltred().environmentObject(FilterKit())
    }
}
