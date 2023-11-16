//
//  NetworkLoggerPlugin.swift
//  D3N
//
//  Created by 송영모 on 11/4/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import Moya

final class D3NNetworkLoggerPlugin: PluginType {
    func willSend(_ request: RequestType, target _: TargetType) {
        guard let request = request.request, let method = request.method else {
            print("Invalid Request")
            return
        }
        print("==============[willSend]==============")
        print("[Logger - ✅ Header] \(request.headers)")
        print("[Logger - ✅ Body] \(String(describing: String(data: request.httpBody ?? Data(), encoding: .utf8)))")
        print("[Logger - ✅ Endpoint] String(describing: [\(method.rawValue)] - \(String(describing: request.url)))")
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("==============[didReceive]==============")
        print("[Logger - ✅ request] \(target.baseURL)/\(target.path)")

        switch result {
        case let .success(response):
            print("[Logger - ✅ result] ⭕️ SUCCESS")
            if let json = String(bytes: response.data, encoding: .utf8) {
                print("📌 statusCode: \(response.statusCode)")
                print(json)
            }
        case let .failure(error):
            print("[Logger - ✅ result] ❌ FAILURE")
            print(error)
        }
    }
}
