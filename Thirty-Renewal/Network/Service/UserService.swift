//
//  UserService.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/16.
//

import Combine
import Foundation

protocol UserAPI {
    func checkIdDuplicate(request: JSONConvertible) -> AnyPublisher<EmptyResponse, NetworkError>
//    func sendMessage(request: JSONConvertible) -> AnyPublisher<UserPhoneEntity.Response, NetworkError>
    func checkCertiNum(request: JSONConvertible) -> AnyPublisher<CommonResponse, NetworkError>
//    func getRegionList() -> AnyPublisher<CommonListResponse<RegionEntity.Response>, NetworkError>
//    func getSiteList(request: JSONConvertible) -> AnyPublisher<CommonListResponse<SiteEntity.Response>, NetworkError>
    func homeNetLogin(request: JSONConvertible) -> AnyPublisher<EmptyResponse, NetworkError>
//    func findId(request: JSONConvertible) -> AnyPublisher<UserFindIdEntity.Response, NetworkError>
    func checkVerification(request: JSONConvertible) -> AnyPublisher<CommonResponse, NetworkError>
    func withDrawal() -> AnyPublisher<CommonResponse, NetworkError>
}

class UserService: UserAPI {
    private var networkRequest: Requestable
    private var environment: NetworkEnvironment = networkEnvironment
    
    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }
    
    func checkIdDuplicate(request: JSONConvertible) -> AnyPublisher<EmptyResponse, NetworkError> {
        let endPoint = UserServiceEndPoints.checkIdDuplicate(request)
        let request = endPoint.createRequest()
        
        return self.networkRequest.request(request)
    }
    
//    func sendMessage(request: JSONConvertible) -> AnyPublisher<UserPhoneEntity.Response, NetworkError> {
//        let endPoint = UserServiceEndPoints.sendMessage(request)
//        let request = endPoint.createRequest()
//
//        return self.networkRequest.request(request)
//    }
    
    func checkCertiNum(request: JSONConvertible) -> AnyPublisher<CommonResponse, NetworkError> {
        let endPoint = UserServiceEndPoints.checkMessageVerification(request)
        let request = endPoint.createRequest()
        
        return self.networkRequest.request(request)
    }
    
//    func getRegionList() -> AnyPublisher<CommonListResponse<RegionEntity.Response>, NetworkError> {
//        let endPoint = UserServiceEndPoints.getRegionList
//        let request = endPoint.createRequest(tokenUse: true)
//
//        return self.networkRequest.request(request)
//    }
//
//    func getSiteList(request: JSONConvertible) -> AnyPublisher<CommonListResponse<SiteEntity.Response>, NetworkError> {
//        let endPoint = UserServiceEndPoints.getSiteList(request)
//        let request = endPoint.createRequest(tokenUse: true)
//
//        return self.networkRequest.request(request)
//    }
    
    func homeNetLogin(request: JSONConvertible) -> AnyPublisher<EmptyResponse, NetworkError> {
        let endPoint = UserServiceEndPoints.homenetLogin(request)
        let request = endPoint.createRequest(tokenUse: true)
        
        return self.networkRequest.request(request)
    }
    
//    func findId(request: JSONConvertible) -> AnyPublisher<UserFindIdEntity.Response, NetworkError> {
//        let endPoint = UserServiceEndPoints.findId(request)
//        let request = endPoint.createRequest()
//
//        return self.networkRequest.request(request)
//    }
    
    func checkVerification(request: JSONConvertible) -> AnyPublisher<CommonResponse, NetworkError> {
        let endPoint = UserServiceEndPoints.sendMessageWithId(request)
        let request = endPoint.createRequest()
        
        return self.networkRequest.request(request)
    }
    
    func withDrawal() -> AnyPublisher<CommonResponse, NetworkError> {
        let endPoint = UserServiceEndPoints.withDrawal
        let request = endPoint.createRequest(tokenUse: true)
        
        return self.networkRequest.request(request)
    }
}

enum UserServiceEndPoints {
    case checkIdDuplicate(JSONConvertible)
    case checkPhoneNumDuplicate(JSONConvertible)
    case sendMessage(JSONConvertible)
    case sendMessageWithId(JSONConvertible)
    case checkMessageVerification(JSONConvertible)
    case getRegionList
    case getSiteList(JSONConvertible)
    case homenetLogin(JSONConvertible)
    case signUp(id: String, pwd: String)
    case findId(JSONConvertible)
    case withDrawal
    
    var httpMethod: HTTPMethod {
        switch self {
        case .checkIdDuplicate, .checkPhoneNumDuplicate, .getRegionList, .getSiteList, .findId:
            return .GET
        case  .sendMessage, .sendMessageWithId, .checkMessageVerification, .signUp, .homenetLogin:
            return .POST
        case .withDrawal:
            return .DELETE
        }
    }
    
    func createRequest(tokenUse: Bool = false) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        if tokenUse {
            let tempToken = ""
            headers["Authorization"] = "Bearer \(tempToken)"
        }
        return NetworkRequest(headers: headers, parameters: parameters, path: path, httpMethod: httpMethod)
    }
    
    var parameters: RequestParams? {
        switch self {
        case .checkIdDuplicate(let request):
            return .query(request)
        case .checkPhoneNumDuplicate(let request):
            return .query(request)
        case .sendMessage(let request):
            return .body(request)
        case .sendMessageWithId(let request):
            return .body(request)
        case .checkMessageVerification(let request):
            return .body(request)
        case .getSiteList(let request):
            return .query(request)
        case .homenetLogin(let request):
            return .body(request)
        case .findId(let request):
            return .query(request)
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .checkIdDuplicate:
            return "/users/check"
        case .checkPhoneNumDuplicate:
            return "/users/phone-number/check"
        case .sendMessage:
            return "/verifications/sms"
        case .sendMessageWithId:
            return "/verifications"
        case .checkMessageVerification:
            return "/verifications/check"
        case .getRegionList:
            return "/regions"
        case .getSiteList:
            return "/sites"
        case .homenetLogin:
            return "/homenets/login"
        case .signUp:
            return "/signup"
        case .findId:
            return "/users/find"
        case .withDrawal:
            return "/me"
        }
    }
}
