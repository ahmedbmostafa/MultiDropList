//
//  CategoryCellViewModel.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Foundation

class CategoryCellViewModel {

    var catName: String
    var catId: String
    var category: CategoryDataModel?

    init(_ category: CategoryDataModel?){
        self.category = category
        self.catName = category?.name ?? ""
        self.catId = "\(category?.id ?? 0)"
    }
    
}
