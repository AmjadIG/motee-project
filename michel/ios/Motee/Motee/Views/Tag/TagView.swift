//
//  TagView.swift
//  Motee
//
//  Created by user165102 on 3/12/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct TagView: View {
    @EnvironmentObject var fk : FilterKit
    var body : some View {
        
        VStack{
            Text("todo")
//            HStack{
//                List{
//                    ForEach(self.fk.tags){ tag in
//                        tag.label
//                    }
//
//                }
//
//            }
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView().environmentObject(FilterKit())
    }
}

