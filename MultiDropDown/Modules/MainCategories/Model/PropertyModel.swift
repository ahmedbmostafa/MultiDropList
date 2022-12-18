//
//  PropertyModel.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Foundation

struct PropertyResponseModel: Codable {
    let code: Int?
    let msg: String?
    let data: [PropertyModel]?
}

// MARK: - Datum
struct PropertyModel: Codable {
    let id: Int?
    let name, datumDescription, slug: String?
    let parent: Int?
    let list: Bool?
    let type: String?
    let value: String?
    let options: [OptionModel]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case slug, parent, list, type, value
        case options
    }
}

// MARK: - Option
struct OptionModel: Codable {
    let id: Int?
    let name, slug: String?
    let parent: Int?
    let child: Bool?
}
