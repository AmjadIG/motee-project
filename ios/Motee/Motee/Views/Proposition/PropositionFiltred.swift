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
    var filtre : String
    var tags : [Tag]
    @State var props : [Proposition] = []
    
    init(filtre : String, tags : [Tag]){
        self.filtre = filtre
        self.tags = tags
        _props = State(wrappedValue: PropositionModel.getFilteredProps(filter: filtre, tags: tags))
    }
    

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
        PropositionFiltred(filtre: "asc",tags: []).environmentObject(FilterKit())
    }
}
