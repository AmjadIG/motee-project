//
//  HttpRequest.swift
//  Motee
//
//  Created by Amjad Menouer on 24/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI
import Foundation


//Données : Dictionnaire prenant en clé un string, et en valeur, n'importe quel type
//Résultat : Transforme le dictionnaire, en array => utile surtout pour les requêtes
func purifyRequest(dictionary : [String:Any])->[Any]{
    var arrayAny : [Any] = []
    for(_,value) in dictionary {
        arrayAny.append(value)
    }
    return arrayAny
}

//Donnée : Tableau T de Tags
//Résultat : Renvoie un string composé pour un URL particulier
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

//Donnée : Tableau T de Tags
//Résultat : Renvoie un string composé pour le corps d'une requête
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

//Donnée : un string (représentant le token)
//Résultat : un string (représentant le token avec son en-tête "Bearer)
func getFullToken(token : String)->String{
    var altS = token
    for _ in 0..<10 {
        altS.removeFirst()
    }
    altS.removeLast()
    altS.removeLast()
    return "Bearer \(altS)"
}

//Donnée : un string (représentant une date, pas au bon format)
//Résultat : un string (représentant une date au bon format)
func getGoodDate(wrongD : String)->String{
    var bufferDate = wrongD
    
    
    
    var year = ""
    var month = ""
    var day = ""
    
    var hour = ""
    var minute = ""

    year.append(bufferDate.first!);bufferDate.removeFirst()
    year.append(bufferDate.first!);bufferDate.removeFirst()
    year.append(bufferDate.first!);bufferDate.removeFirst()
    year.append(bufferDate.first!);bufferDate.removeFirst()
    
    bufferDate.removeFirst()
    
    month.append(bufferDate.first!);bufferDate.removeFirst()
    month.append(bufferDate.first!);bufferDate.removeFirst()
    
    bufferDate.removeFirst()
    
    day.append(bufferDate.first!);bufferDate.removeFirst()
    day.append(bufferDate.first!);bufferDate.removeFirst()

    bufferDate.removeFirst() //T
    
    hour.append(bufferDate.first!);bufferDate.removeFirst()
    hour.append(bufferDate.first!);bufferDate.removeFirst()
    
    bufferDate.removeFirst() //T

    minute.append(bufferDate.first!);bufferDate.removeFirst()
    minute.append(bufferDate.first!);bufferDate.removeFirst()
    
    let dateExactDay : String = "\(day)/\(month)/\(year)"
    let dateHour : String = "\(hour)h\(minute)"
    
    return "le \(dateExactDay) à \(dateHour)"

}
