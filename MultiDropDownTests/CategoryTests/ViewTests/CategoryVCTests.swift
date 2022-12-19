//
//  CategoryVCTests.swift
//  MultiDropDownTests
//
//  Created by AhmedHD_SL on 19/12/2022.
//

import XCTest
@testable import MultiDropDown

class CategoryVCTests: XCTestCase {

    var viewModel: MockCategoryViewModel!
    var view: CategoryVC!

    override func setUp() {
        super.setUp()
        viewModel = MockCategoryViewModel()
        view = CategoryVC.instantiate(fromAppStoryboard: .Main)
        view.viewModel = viewModel
        viewModel.didLoad()
        view.loadView()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        view = nil
    }
    
    func testGetCategoryDataSourceViewModels(){
        XCTAssertTrue(viewModel.isGetCategoryCellViewModels == true)
        XCTAssertTrue(viewModel.getCategoryDataSourceViewModels().count == 1)
    }

    func testGetCategoryList() {
        view.categoryView.items = viewModel.getCategoryList()
        XCTAssertTrue(viewModel.isGetCategoryList == true)
        XCTAssertTrue(view.categoryView.items.count == 1)
        XCTAssertTrue(view.categoryView.items.first?.displayableValue == "سيارات ودرجات ومستلزماتها")
    }
    
    func testGetSubCategoryList() {
        let cat = viewModel.getCategoryCellViewModel(index: 0)
        view.subCategoryView.items = viewModel.getSubCategoryList(dataModel: cat.category?.children)
        
        XCTAssertTrue(viewModel.isGetCategoryCellViewModel == true)
        XCTAssertTrue(viewModel.isGetSubCategoryList == true)
        XCTAssertTrue(view.subCategoryView.items.count == 1)
        XCTAssertTrue(view.subCategoryView.items.first?.displayableValue == "سيارات")
    }
}
