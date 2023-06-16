//
//  CommonResponse.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/16.
//

import Foundation

struct CommonResponse: Codable {
    var statusCode: Int?
    var message: String?
}

struct CommonListResponse<T: Codable>: Codable {
    var contents: [T]?
    var content: [T]?
    var totalElements: Int?
    var numberOfElements: Int?
}

public struct EmptyResponse: Codable { }
