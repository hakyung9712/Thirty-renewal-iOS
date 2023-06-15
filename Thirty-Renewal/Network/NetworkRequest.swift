//
//  NetworkRequest.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/15.
//

import Foundation

public enum RequestParams {
    case query(_ parameter: JSONConvertible?)
    case body(_ parameter: JSONConvertible?)
}

public struct NetworkRequest {
    let baseURL: String
    let headers: [String: String]?
    let parameters: RequestParams?
    let path: String
    let requestTimeOut: Float
    let httpMethod: HTTPMethod
    
    public init(headers: [String : String]?,
                parameters: RequestParams?,
                path: String,
                requestTimeOut: Float,
                httpMethod: HTTPMethod) {
        self.baseURL = BASE_URL
        self.headers = headers
        self.parameters = parameters
        self.path = path
        self.requestTimeOut = requestTimeOut
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        
        switch parameters {
        case .query(let parameter):
            let dict = try? parameter?.toJSONDictionary()
            let queryParams = dict?.compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .body(let parameter):
            urlRequest.httpBody = try? parameter?.toJSONData()
        case .none:
            return urlRequest
        }
        return urlRequest
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(statusCode: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}
