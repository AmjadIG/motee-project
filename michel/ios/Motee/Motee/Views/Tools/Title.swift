//
//  Title.swift
//  exemple
//
//  Created by Rayan Bahroun on 27/02/2020.
//  Copyright © 2020 Rayan Bahroun. All rights reserved.
//

import SwiftUI

struct Title: View {
    var myTitle : String = ""
    var body: some View {
        Text(myTitle)
            .bold()
            .font(.largeTitle)
            .padding(.vertical, 20)
    }
}

struct Title_Previews: PreviewProvider {
    @State static var title : String = "Title"
    static var previews: some View {
        Title(myTitle: title)
    }
}

