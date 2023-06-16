//
//  UserEntity.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/16.
//

import Foundation

enum UserEntity {
    struct Request: Codable, JSONConvertible {
        let username: String
    }
}
