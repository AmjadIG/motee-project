//
//  textFieldGenerator.swift
//  exemple
//
//  Created by Rayan Bahroun on 29/02/2020.
//  Copyright © 2020 Rayan Bahroun. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct FieldGenerator<FieldView>: View where FieldView : View {
    var label : String
    var field : String
    var body: some View {
        VStack {
            if(label.count > 0){
                HStack {
                    Text(label)
                    Spacer()
                }
            }
            fieldView
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
        }.padding(.horizontal,10)
    }
    
    fileprivate init(label: String, field : String , fieldView: FieldView) {
        self.label = label
        self.field = field
        self.fieldView = fieldView
    }
    
    private let fieldView: FieldView
}

extension FieldGenerator where FieldView == TextField<Text> {
    static func plain(label: String,field : String, text: Binding<String>) -> some View {
        return Self(label: label, field : field, fieldView: TextField(field, text: text))
    }
}

extension FieldGenerator where FieldView == SecureField<Text> {
    static func secure(label: String, field : String, text: Binding<String>) -> some View {
        return Self(label: label,field: field, fieldView: SecureField(field, text: text))
    }
}
