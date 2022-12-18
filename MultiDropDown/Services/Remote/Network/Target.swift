//
//  Target.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Alamofire

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum Task {
    case requestPlain // without parameters
    case requestParameters(parameters: Parameters)
}

protocol TargetType {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: HTTPHeaders { get }
}
