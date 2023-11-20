//
//  AuthInterceptor.swift
//  D3N
//
//  Created by 송영모 on 11/16/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Alamofire
import Moya

import Dependencies

final class AuthInterceptor: RequestInterceptor {
    @Dependency(\.authClient) var authClient

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: LocalStorageManager.load(.accessToken) ?? ""))
        completion(.success(urlRequest))
    }

    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) async {
        //FIXME: 동작안함.
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        let result = await authClient.refresh()
        
        switch result {
        case let .success(authEntity):
            LocalStorageManager.save(.accessToken, value: authEntity.accessToken)
            LocalStorageManager.save(.accessToken, value: authEntity.accessToken)
            completion(.retry)
        case let .failure(error):
            completion(.doNotRetryWithError(error))
        }
    }
}
