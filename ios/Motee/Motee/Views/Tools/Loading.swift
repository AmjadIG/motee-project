//
//  Loading.swift
//  Motee
//
//  Created by Rayan Bahroun on 4/2/20.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct Loading: View {
    @State var spin = false
    var body: some View {
         ZStack{
            Image(systemName: "arrow.2.circlepath.circle.fill")
                .resizable()
                .frame(width: 128, height: 128)
                .rotationEffect(.degrees(spin ? 360:0))
                .foregroundColor(Color.orange)
                .animation(Animation.linear(duration: 0.8))
                .onAppear() {
                    self.spin.toggle()
            }
        }
    }
}
