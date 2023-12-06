//
//  NetworkProvider.swift
//  D3N
//
//  Created by 송영모 on 11/4/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import Moya

public enum D3NAPIError: Error {
    case unAuth
    case jsonParseError
    case none
}

final class D3NAPIProvider {
    private static let provider = MoyaProvider<MultiTarget>(
        session: Session(interceptor: AuthInterceptor()),
        plugins: [D3NNetworkLoggerPlugin()]
    )
    
    static func reqeust<R: Codable>(target: TargetType) async -> Result<R, D3NAPIError>{
        let response = await self.request(target: target)
        switch response {
        case .success(let success):
            switch success.statusCode {
            case 200..<300: break
            case 300..<400: break
            case 401: return .failure(.unAuth)
            default: break
            }
            
            if let response = try? JSONDecoder().decode(R.self, from: success.data) {
                return .success(response)
            } else {
                return .failure(.jsonParseError)
            }
        case .failure(let failure):
            return .failure(.none)
        }
    }
    
    static func justRequest(target: TargetType) async -> Result<Bool, D3NAPIError> {
        let response = await self.request(target: target)
        
        switch response {
        case .success(let success):
            switch success.statusCode {
            case 200..<300: break
            case 300..<400: return .failure(.none)
            case 401: return .failure(.unAuth)
            default: break
            }
            
            return .success(true)
        case .failure(let failure):
            return .failure(.none)
        }
    }
    
    public static func request<T: TargetType>(target: T) async -> Result<Response, MoyaError> {
        await withCheckedContinuation { continuation in
            provider.request(MultiTarget(target)) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
