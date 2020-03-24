//
//  HttpRequest.swift
//  Motee
//
//  Created by Amjad Menouer on 24/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI
import Foundation

func purifyRequest(dictionary : [String:Any])->[Any]{
    var arrayAny : [Any] = []
    for(_,value) in dictionary {
        arrayAny.append(value)
    }
    return arrayAny
}
