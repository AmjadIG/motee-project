//
//  filterKit.swift
//  Motee
//
//  Created by user165102 on 3/12/20.
//  Copyright © 2020 groupe3. All rights reserved.
//
            
import Foundation
            
class FilterKit: ObservableObject, Identifiable{
    @Published var filtered : String = "all"
    @Published var showFilters : Bool = false
    @Published var tags : [Tag] = [Tag(label: "tag1"),Tag(label: "tag2"),Tag(label: "tag3"),Tag(label: "tag5"),Tag(label: "tag5"),Tag(label: "tag6")]
}
