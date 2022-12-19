//
//  CategoryBuilderTests.swift
//  MultiDropDownTests
//
//  Created by AhmedHD_SL on 19/12/2022.
//

import XCTest
@testable import MultiDropDown

class CategoryBuilderTests: XCTestCase {

    var view: CategoryVC!
    var appFlowManager: AppFlowManager!

    override func setUp() {
        super.setUp()
        appFlowManager = AppFlowManager()
        view = appFlowManager.creatCategoryVC() as! CategoryVC
    }

    override func tearDown() {
        super.tearDown()
        view = nil
    }

    func testBuildViewModel() {
        XCTAssertTrue(view.viewModel != nil)
        XCTAssertTrue(view.propViewModel != nil)
        XCTAssertTrue(view.viewModel.dataProvider != nil)
        XCTAssertTrue(view.propViewModel.dataProvider != nil)
    }

    func testBuildVC() {
        XCTAssertTrue(view != nil)
    }


}
