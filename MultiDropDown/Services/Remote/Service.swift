//
//  Service.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Alamofire

protocol CategoryServiceProtocol {
    func fetchCategories(completion: @escaping (Result<CategoryResponseModel?, AFError>) -> Void)
    func fetchProperties(catId: Int, completion: @escaping (Result<PropertyResponseModel?, AFError>) -> Void)
    func fetchOptionsChild(childId: Int, completion: @escaping (Result<PropertyResponseModel?, AFError>) -> Void)

}

class CategoryServiceImp: BaseAPI<EndPoint>, CategoryServiceProtocol {

    func fetchCategories(completion: @escaping (Result<CategoryResponseModel?, AFError>) -> Void) {
        self.fetchCategories(target: .fetchCategories) { (result) in
            completion(result)
        }
    }
    
    func fetchProperties(catId: Int, completion: @escaping (Result<PropertyResponseModel?, AFError>) -> Void) {
        self.fetchProperties(target: .fetchProperties(catId: catId)) { (result) in
            completion(result)
        }
    }
    
    func fetchOptionsChild(childId: Int, completion: @escaping (Result<PropertyResponseModel?, AFError>) -> Void) {
        self.fetchProperties(target: .getOptionsChild(childId: childId)) { (result) in
            completion(result)
        }
    }
}
