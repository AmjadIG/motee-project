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
    @Published var currentUser : User? = UserModel.getUserById(idUser: "5e68ec5c1ffcde50a4ef65a9")
    @Published var token : String = ""
    @Published var currentPage = "Accueil"
}
