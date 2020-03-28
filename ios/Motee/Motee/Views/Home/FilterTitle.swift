//
//  FilterTitle.swift
//  Motee
//
//  Created by user164568 on 3/27/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct FilterTitle: View {
    @EnvironmentObject var fk : FilterKit
    var body: some View {
        VStack{
            if(self.fk.filtered.elementsEqual("like")){
                Title(myTitle: "Propos les plus entendus")
            }else if self.fk.filtered.elementsEqual("desc"){
                Title(myTitle: "Propos les plus récents")
            }else if self.fk.filtered.elementsEqual("asc"){
                Title(myTitle: "Propos les plus anciens")
            }
        }
        
    }
}
