//
//  PropertyViewModel.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Foundation
import Alamofire

typealias PropertyViewModelOutput = (CategoryViewModel.Output) -> ()

protocol PropertyViewModelProtocol {
    var dataProvider: PropertyDataProviderProtocol! {get}
    var propertyDataSourceViewModels: [PropertyCellViewModel] {get}
    var output: PropertyViewModelOutput? { get set }
    func getPropertyCellViewModel(index : Int) -> PropertyCellViewModel
    func getProcessTypeList() -> [DropListModel]
    func getBrandList(dataModel: [OptionModel]?) -> [DropListModel]
    func getModelList() -> [DropListModel]
    func getTypeList() -> [DropListModel]
    func didLoad(catId: Int)
    func didLoadChild(childId: Int)
}

class PropertyViewModel: PropertyViewModelProtocol{
   
    enum Output {
        case reloadProperty
        case showActivityIndicator(show: Bool)
        case showError(error: Error)
    }

    var dataProvider: PropertyDataProviderProtocol!

    init(withDataProvider dataProvider: PropertyDataProviderProtocol) {
        self.dataProvider = dataProvider
    }

    var output: PropertyViewModelOutput?

    private var propertyViewModels = [PropertyCellViewModel]() {
        didSet {
            output?(.reloadCategory)
        }
    }

     var propertyDataSourceViewModels: [PropertyCellViewModel] {
        return propertyViewModels
    }

    func getPropertyCellViewModel(index: Int) -> PropertyCellViewModel {
        return propertyDataSourceViewModels[index]
    }

    func didLoad(catId: Int) {
        getProperty(catId: catId)
    }

    func getProperty(catId: Int) {
        dataProvider.fetchProperties(catId: catId)
    }
    
    func didLoadChild(childId: Int) {
        getOptionsChild(childId: childId)
    }

    func getOptionsChild(childId: Int) {
        dataProvider.fetchOptionsChild(childId: childId)
    }
    
    func getProcessTypeList() -> [DropListModel] {
        return propertyDataSourceViewModels.map({ prop in
            return DropListModel(id: Int(prop.propId) ?? 0, name: prop.propName)
        })
    }
    
    func getBrandList(dataModel: [OptionModel]?) -> [DropListModel] {
        guard let dataModel = dataModel else {
            return []
        }
        
         return dataModel.map({ prop in
            return DropListModel(id: prop.id ?? 0, name: prop.name ?? "")
        })
    }
    
    func getModelList() -> [DropListModel] {
        let dataOp = propertyDataSourceViewModels.first?.property?.options ?? []
        return  dataOp.map({ prop in
            return DropListModel(id: prop.id ?? 0, name: prop.name ?? "")
        })
    }
    
    func getTypeList() -> [DropListModel] {
        let dataOp = propertyDataSourceViewModels.first?.property?.options ?? []
        return  dataOp.map({ prop in
            return DropListModel(id: prop.id ?? 0, name: prop.name ?? "")
        })
    }
    
}

extension PropertyViewModel: PropertyDataProviderDelegate {

    func showLoader(show: Bool) {
        output?(.showActivityIndicator(show: show))
    }

    func onSuccess(_ data: PropertyResponseModel) {
        guard let categories = data.data else { return }
        propertyViewModels.removeAll()
        propertyViewModels.append(contentsOf: categories.map { PropertyCellViewModel.init($0) })
    }

    func onFailure(_ error: AFError) {
         output?(.showError(error: error))
    }
}
