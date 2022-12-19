//
//  CategoryViewModelTests.swift
//  MultiDropDownTests
//
//  Created by AhmedHD_SL on 19/12/2022.
//

import XCTest
@testable import MultiDropDown

class CategoryViewModelTests: XCTestCase {
    
    var  dataProvider: MockCategoryDataProvider!
    var  viewModel: CategoryViewModel!
    var  view = MockCategoryVC()
    
    override func setUp() {
        super.setUp()
        dataProvider = MockCategoryDataProvider()
        viewModel = CategoryViewModel(withDataProvider: dataProvider)
        dataProvider.delegate = viewModel
        view.viewModel = viewModel
        view.bindViewModelOutput()
    }
    
    override func tearDown() {
        super.tearDown()
        dataProvider = nil
        viewModel = nil
    }
    
    func testGetCategoryMethod() {
        
        dataProvider.closure = { [unowned self] in
            let category = try! JSONDecoder().decode(CategoryResponseModel.self, from: categoryStub)
            self.dataProvider.delegate?.onSuccess(category)
        }
        
        viewModel.getCategory()
        
        let cellViewModel = viewModel.getCategoryCellViewModel(index: 0)
        XCTAssert(cellViewModel.catName == "سيارات ودرجات ومستلزماتها")
    }
    
    func testViewModelNumberOfRows() {
        dataProvider.closure = {  [unowned self] in
            let category = try! JSONDecoder().decode(CategoryResponseModel.self, from: categoryStub)
            self.dataProvider.delegate?.onSuccess(category)
        }
        
        viewModel.getCategory()
        _ = viewModel.getCategoryList()
        
        XCTAssert(viewModel.getCategoryList().count == 1)
        
    }
    
}
