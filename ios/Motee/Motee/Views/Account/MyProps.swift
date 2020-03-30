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
    @State var props : [Proposition]
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack{
                    ForEach(props.indices){ index in
                        PropositionView(proposition: self.$props[index])
                    }
                }.padding(.top, 80)
            }
        }
    }
}
