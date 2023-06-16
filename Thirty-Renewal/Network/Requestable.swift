//
//  Requestable.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/16.
//

import Combine
import Foundation

protocol Requestable {
    func request<T: Codable>(_ request: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

