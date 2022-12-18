//
//  CategoryDataProvider.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Foundation
import Alamofire

protocol CategoryDataProviderDelegate: class {
    func onSuccess(_ category: CategoryResponseModel)
    func onFailure(_ error: AFError)
    func showLoader(show: Bool)
}

protocol CategoryDataProviderProtocol {
    func fetchCategory()
    var delegate: CategoryDataProviderDelegate? { get set }
}

class CategoryDataProviderImpl: CategoryDataProviderProtocol {

    var categoryService: CategoryServiceProtocol!

    private var isFetching = false

    weak var delegate: CategoryDataProviderDelegate?

    func fetchCategory() {
        isFetching = true
        delegate?.showLoader(show: isFetching)
        categoryService.fetchCategories { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            self.delegate?.showLoader(show: self.isFetching)

            switch result {
            case .success(let results):
                guard let data = results else { return }
                print("res=",data.data?.categories?.count)
                self.delegate?.onSuccess(data)
            case .failure(let error):
                self.delegate?.onFailure(error)
            }
        }
    }
}
