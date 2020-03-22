//
//  LoginPicture.swift
//  Motee
//
//  Created by Rayan Bahroun on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct LoginPicture: View {
    var body: some View {
        return Image("1504_21")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 50)
        
    }
}

struct LoginPicture_Previews: PreviewProvider {
    static var previews: some View {
        LoginPicture()
    }
}
