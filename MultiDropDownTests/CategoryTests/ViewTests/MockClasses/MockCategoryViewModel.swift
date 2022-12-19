//
//  MockCategoryViewModel.swift
//  MultiDropDownTests
//
//  Created by AhmedHD_SL on 19/12/2022.
//

import XCTest
@testable import MultiDropDown

class MockCategoryViewModel: CategoryViewModelProtocol {
    
    var isGetCategoryCellViewModel = false
    var isGetCategoryCellViewModels = false
    var isGetCategoryList = false
    var isGetSubCategoryList = false
    var isNumberOfRowsCalls = false
    
    var output: CategoryViewModelOutput?
    var dataProvider: CategoryDataProviderProtocol!
    var categoryDataSourceViewModels: [CategoryCellViewModel]!
    
    func getCategoryDataSourceViewModels() -> [CategoryCellViewModel] {
        isGetCategoryCellViewModels = true
        let category = try! JSONDecoder().decode(CategoryResponseModel.self, from: categoryStub)
        let categories = category.data?.categories ?? []
        categoryDataSourceViewModels = [CategoryCellViewModel]()
        categoryDataSourceViewModels.append(contentsOf: categories.map { CategoryCellViewModel.init($0) })
        return categoryDataSourceViewModels
    }
    
    func getCategoryCellViewModel(index: Int) -> CategoryCellViewModel {
        isGetCategoryCellViewModel = true
        return categoryDataSourceViewModels[index]
    }
    
    func getCategoryList() -> [DropListModel] {
        isGetCategoryList = true
        return categoryDataSourceViewModels.map({ cat in
            return DropListModel(id: Int(cat.catId) ?? 0, name: cat.catName)
        })
    }
    
    func getSubCategoryList(dataModel: [CategoryDataModel]?) -> [DropListModel] {
        isGetSubCategoryList = true
        guard let dataModel = dataModel else {
            return []
        }
        
        return dataModel.map({ cat in
            return DropListModel(id: cat.id ?? 0, name: cat.name ?? "")
        })
    }
    

    func didLoad() {
       _ = getCategoryDataSourceViewModels()
    }
    
}
