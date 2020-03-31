//
//  filterKit.swift
//  Motee
//
//  Created by user165102 on 3/12/20.
//  Copyright © 2020 groupe3. All rights reserved.
//
            
import Foundation
            
class FilterKit: ObservableObject, Identifiable{
    @Published var filtered : String = "like"
    @Published var showFilters : Bool = false
    @Published var showPropositionReport : Bool = false
    @Published var propositionReported : Proposition? = nil
    @Published var showAnswerReport : Bool = false
    @Published var answerReported : Answer? = nil
    @Published var tags : [Tag] = []
    @Published var textSearch : String = ""
    @Published var currentUser : User? = nil
    @Published var token : String = ""
    @Published var currentPage = "Accueil"
}
