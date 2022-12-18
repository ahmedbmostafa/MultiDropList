//
//  PropertyCellViewModel.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Foundation

class PropertyCellViewModel {

    var propName: String
    var propId: String
//    var isChild: Bool
    var property: PropertyModel?

    init(_ property: PropertyModel?){
        self.property = property
        self.propName = property?.name ?? ""
        self.propId = "\(property?.id ?? 0)"
//        self.isChild = property?.options
    }
    
}
