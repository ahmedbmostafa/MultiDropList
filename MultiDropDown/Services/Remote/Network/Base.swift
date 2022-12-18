//
//  Base.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Alamofire
import Foundation

class BaseAPI<T: TargetType> {
    
    func fetchCategories(target: T, completion: @escaping(Result<CategoryResponseModel?, AFError>) -> Void) {
        let method = HTTPMethod(rawValue: target.method.rawValue)
        AF.request(target.base + target.path, method: method, encoding: JSONEncoding.default, headers: target.headers)
            .response { response in
                switch response.result {
                case.success:
                    guard let data = response.value else {return}
                    do {
                        let responseOBj = try JSONDecoder().decode(CategoryResponseModel.self, from: data!)
                        completion(.success(responseOBj))
                        
                    }
                    catch let err{
                        debugPrint(err)
                    }
                case .failure(let err):
                    debugPrint(err)
                    completion(.failure(err))
                }
            }
    }
    
    func fetchProperties(target: T, completion: @escaping(Result<PropertyResponseModel?, AFError>) -> Void) {
        let method = HTTPMethod(rawValue: target.method.rawValue)
        print("url=", target.path)
        AF.request(target.base + target.path, method: method, encoding: JSONEncoding.default, headers: target.headers)
            .response { response in
                switch response.result {
                case.success:
                    guard let data = response.value else {return}
                    do {
                        let responseOBj = try JSONDecoder().decode(PropertyResponseModel.self, from: data!)
                        completion(.success(responseOBj))
                    
                    }
                    catch let err{
                        debugPrint(err)
                    }
                case .failure(let err):
                    debugPrint(err)
                    completion(.failure(err))
                }
            }
    }
}
