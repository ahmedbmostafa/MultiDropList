//
//  PropertyDataProvider.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Foundation
import Alamofire

protocol PropertyDataProviderDelegate: class {
    func onSuccess(_ property: PropertyResponseModel)
    func onFailure(_ error: AFError)
    func showLoader(show: Bool)
}

protocol PropertyDataProviderProtocol {
    func fetchProperties(catId: Int)
    func fetchOptionsChild(childId: Int)
    var delegate: PropertyDataProviderDelegate? { get set }
}

class PropertyDataProviderImpl: PropertyDataProviderProtocol {
 
    var categoryService: CategoryServiceProtocol!

    private var isFetching = false

    weak var delegate: PropertyDataProviderDelegate?

    func fetchProperties(catId: Int) {
        isFetching = true
        delegate?.showLoader(show: isFetching)
        categoryService.fetchProperties(catId: catId) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            self.delegate?.showLoader(show: self.isFetching)

            switch result {
            case .success(let results):
                guard let data = results else { return }
                print("resProp=",data.data?.count)
                self.delegate?.onSuccess(data)
            case .failure(let error):
                self.delegate?.onFailure(error)
            }
        }
    }
    
    func fetchOptionsChild(childId: Int) {
        isFetching = true
        delegate?.showLoader(show: isFetching)
        categoryService.fetchOptionsChild(childId: childId) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            self.delegate?.showLoader(show: self.isFetching)

            switch result {
            case .success(let results):
                guard let data = results else { return }
                print("resProp=",data.data?.count)
                self.delegate?.onSuccess(data)
            case .failure(let error):
                self.delegate?.onFailure(error)
            }
        }
    }
}
