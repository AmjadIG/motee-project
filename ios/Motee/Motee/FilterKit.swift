//
//  filterKit.swift
//  Motee
//
//  Created by user165102 on 3/12/20.
//  Copyright © 2020 groupe3. All rights reserved.
//
            
import Foundation
            
class FilterKit: ObservableObject, Identifiable{
    @Published var filtered : String = "asc"
    @Published var showFilters : Bool = false
    @Published var tags : [Tag] = []
    @Published var currentUSer : User? = nil
}
