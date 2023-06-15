//
//  NativeRequestable.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/15.
//

import Combine
import Foundation

public class NativeRequestable {
    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError> where T: Codable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut)
        
        guard let url = URL(string: req.baseURL) else {
            return AnyPublisher(Fail<T, NetworkError>(error: NetworkError.badURL("Invalid URL")))
        }
        
        NetworkLogger.requestLog(request: req.buildURLRequest(with: url))
        
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server Error")
                }
                
                if let response = output.response as? HTTPURLResponse {
                    NetworkLogger.responseLog(data: output.data, response: response, error: nil)
                }
                
                guard let statusCode = (output.response as? HTTPURLResponse)?.statusCode as? Int else {
                    throw NetworkError.unknown(code: 0, error: "Status code Out of bounds Error")
                }
                
                if (200..<299) ~= statusCode {
                    return output.data.isEmpty ? "{}".data(using: .utf8)! : output.data
                }else {
                    throw NetworkError.apiError(statusCode: statusCode, error: "\(statusCode) Error")
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
        
    }
}
