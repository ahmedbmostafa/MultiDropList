//
//  CategoryViewModel.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Foundation
import Alamofire

typealias CategoryViewModelOutput = (CategoryViewModel.Output) -> ()

protocol CategoryViewModelProtocol {
    var dataProvider: CategoryDataProviderProtocol! {get}
    var categoryDataSourceViewModels: [CategoryCellViewModel]! {get}
    var output: CategoryViewModelOutput? { get set }
    func getCategoryCellViewModel(index : Int) -> CategoryCellViewModel
    func getCategoryList() -> [DropListModel]
    func getSubCategoryList(dataModel: [CategoryDataModel]?) -> [DropListModel]
    func didLoad()
}

class CategoryViewModel: CategoryViewModelProtocol{
    
    enum Output {
        case reloadCategory
        case showActivityIndicator(show: Bool)
        case showError(error: Error)
    }
    
    var dataProvider: CategoryDataProviderProtocol!
    
    init(withDataProvider dataProvider: CategoryDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    var output: CategoryViewModelOutput?
    
    private var categoryViewModels = [CategoryCellViewModel]() {
        didSet {
            output?(.reloadCategory)
        }
    }
    
    var categoryDataSourceViewModels: [CategoryCellViewModel]!{
        return categoryViewModels
    }
    
    func getCategoryCellViewModel(index: Int) -> CategoryCellViewModel {
        return categoryDataSourceViewModels[index]
    }
    
    func didLoad() {
        getCategory()
    }
    
    func getCategory() {
        dataProvider.fetchCategory()
    }
    
    func getCategoryList() -> [DropListModel] {
        return categoryDataSourceViewModels.map({ cat in
            return DropListModel(id: Int(cat.catId) ?? 0, name: cat.catName)
        })
    }
    
    func getSubCategoryList(dataModel: [CategoryDataModel]?) -> [DropListModel] {
        
        guard let dataModel = dataModel else {
            return []
        }
        
        return dataModel.map({ cat in
            return DropListModel(id: cat.id ?? 0, name: cat.name ?? "")
        })
    }
    
}

extension CategoryViewModel: CategoryDataProviderDelegate {
    
    func showLoader(show: Bool) {
        output?(.showActivityIndicator(show: show))
    }
    
    func onSuccess(_ data: CategoryResponseModel) {
        guard let categories = data.data?.categories else { return }
        categoryViewModels.append(contentsOf: categories.map { CategoryCellViewModel.init($0) })
    }
    
    func onFailure(_ error: AFError) {
        output?(.showError(error: error))
    }
}
