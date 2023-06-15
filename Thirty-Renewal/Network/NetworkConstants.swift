//
//  NetworkConstants.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/15.
//

import Foundation

public var networkEnvironment: NetworkEnvironment = .dev

public var BASE_URL: String {
    switch networkEnvironment {
    case .dev:
        return ""
    case .prod:
        return ""
    }
}

public enum NetworkEnvironment: String, CaseIterable {
    case dev
    case prod
}
