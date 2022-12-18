//
//  CategoryModel.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import Foundation

// MARK: - ResponseModel
struct CategoryResponseModel: Codable {
    let code: Int?
    let msg: String?
    let data: CategoryModel?
}

// MARK: - DataClass
struct CategoryModel: Codable {
    let categories: [CategoryDataModel]?
    let statistics: StatisticsModel?
    let adsBanners: [AdsBannerModel]?

    enum CodingKeys: String, CodingKey {
        case categories, statistics
        case adsBanners = "ads_banners"
    }
}

// MARK: - Category
struct CategoryDataModel: Codable {
    let id: Int?
    let name: String?
    let categoryDescription: String?
    let image: String?
    let slug: String?
    let children: [CategoryDataModel]?
    let circleIcon: String?
    let disableShipping: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case categoryDescription = "description"
        case image, slug, children
        case circleIcon = "circle_icon"
        case disableShipping = "disable_shipping"
    }
}


// MARK: - Statistics
struct StatisticsModel: Codable {
    let auctions, users, products: Int?
}


// MARK: - AdsBanner
struct AdsBannerModel: Codable {
    let img: String?
    let mediaType: String?
    let duration: Int?

    enum CodingKeys: String, CodingKey {
        case img
        case mediaType = "media_type"
        case duration
    }
}


