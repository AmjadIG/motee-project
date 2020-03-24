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

func paramTags(tags: [Tag])->String {
    var postString = ""
    var iterator = 1
    
    for tag in tags {
        if tag.equals(otherTag : tags[0]) {
            postString += "?"
        }
        postString += "tag" + String(iterator) + "=" + tag.id
        iterator += 1
        if !tag.equals(otherTag : tags[tags.count-1]) {
            postString += "&"
        }
    }
    return postString
}

func paramTagsToLabel(tags: [Tag])->String {
    var string = ""
    for tag in tags {
        string += tag.label
        if !tag.equals(otherTag : tags[tags.count-1]) {
            string += " "
        }
    }
    return string
}
