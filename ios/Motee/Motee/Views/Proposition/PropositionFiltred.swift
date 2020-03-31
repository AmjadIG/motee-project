//
//  PropositionFiltred.swift
//  Motee
//
//  Created by user165102 on 3/23/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionFiltred : View {
    @EnvironmentObject var fk : FilterKit
    @State var props : [Proposition]
    var body: some View {
        VStack{
            ForEach(props.indices){ index in
                if self.fk.textSearch.isEmpty  {
                    PropositionView(proposition: self.$props[index])
                }else{
                    if self.props[index].contentPub.contains(self.fk.textSearch) {
                        PropositionView(proposition: self.$props[index])
                    }
                }
            }
        }
    }
}
struct PropositionFiltred_Previews: PreviewProvider {
    @State static var props = PropositionModel.getFilteredProps(filter: "asc", tags: [])
    @State static var textSearch = "fille"
    static var previews: some View {
        PropositionFiltred(props: props).environmentObject(FilterKit())
    }
}
