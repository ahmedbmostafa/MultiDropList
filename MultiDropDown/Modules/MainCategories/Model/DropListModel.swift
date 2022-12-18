//
//  DropListModel.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 18/12/2022.
//

import Foundation
import SwiftyMenu


struct DropListModel {
    let id: Int
    let name: String
}

extension DropListModel: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return self.name
    }

    public var retrievableValue: Any {
        return self.id
    }
}
