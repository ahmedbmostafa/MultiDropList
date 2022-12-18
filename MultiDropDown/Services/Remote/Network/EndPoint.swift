//
//  EndPoint.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Alamofire

enum EndPoint {
    case fetchCategories
    case fetchProperties(catId: Int)
    case getOptionsChild(childId: Int)
}

extension EndPoint: TargetType {

    var base: String {
        switch self {
        default:
            return APIConstants.BaseURL
        }
    }
    var path: String {
        switch self {
        case .fetchCategories:
            return "get_all_cats"
            
        case .fetchProperties(let catId):
            return "properties?cat=\(catId)"
            
        case .getOptionsChild(let childId):
            return "get-options-child/\(childId)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchCategories:
            return .get
            
        case .fetchProperties:
            return .get
        case .getOptionsChild:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .fetchCategories:
            return .requestPlain
        case .fetchProperties:
            return .requestPlain
        case .getOptionsChild:
            return .requestPlain
        }
    }

    var headers: HTTPHeaders {
        switch self {
        default:
            let header: HTTPHeaders = ["Content-Type": "application/json; charset=utf-8"]
            return header
        }
    }
}
