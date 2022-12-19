//
//  MockCategoryDataProvider.swift
//  MultiDropDownTests
//
//  Created by AhmedHD_SL on 19/12/2022.
//

import XCTest
@testable import MultiDropDown

class MockCategoryDataProvider: CategoryDataProviderProtocol {
   
    var delegate: CategoryDataProviderDelegate?

    var closure: (() -> ())?

    func fetchCategory() {
        closure?()
    }
    
}
